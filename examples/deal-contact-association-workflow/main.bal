import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample IDs representing a real-world customer onboarding scenario
// In production, these would come from your CRM data or webhook events
configurable string companyId = "12345678901";
configurable string dealId = "98765432101";

public function main() returns error? {
    io:println("=== Customer Onboarding Association Workflow ===");
    io:println("This workflow ensures CRM data integrity during sales handoffs to customer success teams.\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    io:println("✓ HubSpot CRM Associations client initialized successfully.\n");

    // Step 1: Read existing associations between the company and its contacts
    io:println("Step 1: Reading existing company-to-contact associations...");
    io:println("        Company ID: " + companyId);
    
    associations:BatchInputPublicFetchAssociationsBatchRequest companyContactsRequest = {
        inputs: [
            {
                id: companyId
            }
        ]
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel companyContactsResponse = 
        check hubspotClient->/associations/companies/contacts/batch/read.post(companyContactsRequest);
    
    io:println("        Status: " + companyContactsResponse.status);
    io:println("        Completed at: " + companyContactsResponse.completedAt);
    
    // Extract contact IDs from the company associations
    string[] contactIds = [];
    foreach associations:PublicAssociationMultiWithLabel result in companyContactsResponse.results {
        io:println("        Found associations for company: " + result.'from.id);
        foreach associations:MultiAssociatedObjectWithLabel contact in result.to {
            contactIds.push(contact.toObjectId);
            io:println("          - Contact ID: " + contact.toObjectId);
            foreach associations:AssociationSpecWithLabel assocType in contact.associationTypes {
                int? typeIdValue = <int?>assocType["typeId"];
                string? categoryValue = <string?>assocType["category"];
                string typeIdStr = typeIdValue is int ? typeIdValue.toString() : "unknown";
                string categoryStr = categoryValue is string ? categoryValue : "unknown";
                io:println("            Association Type ID: " + typeIdStr + 
                          ", Category: " + categoryStr);
            }
        }
    }
    
    if contactIds.length() == 0 {
        io:println("\n⚠ No contacts found associated with the company. Workflow cannot proceed.");
        io:println("  Please ensure the company has associated contacts before running this workflow.");
        return;
    }
    
    io:println("\n        Total contacts found: " + contactIds.length().toString() + "\n");

    // Step 2: Batch create associations between the deal and all company contacts
    io:println("Step 2: Creating deal-to-contact associations...");
    io:println("        Deal ID: " + dealId);
    io:println("        Associating with " + contactIds.length().toString() + " contacts...");
    
    // Build the batch association request
    associations:PublicDefaultAssociationMultiPost[] associationInputs = [];
    foreach string contactId in contactIds {
        associations:PublicDefaultAssociationMultiPost assocInput = {
            'from: {
                id: dealId
            },
            to: {
                id: contactId
            }
        };
        associationInputs.push(assocInput);
    }
    
    associations:BatchInputPublicDefaultAssociationMultiPost batchAssociateRequest = {
        inputs: associationInputs
    };
    
    associations:BatchResponsePublicDefaultAssociation batchAssociateResponse = 
        check hubspotClient->/associations/deals/contacts/batch/associate/'default.post(batchAssociateRequest);
    
    io:println("        Status: " + batchAssociateResponse.status);
    io:println("        Completed at: " + batchAssociateResponse.completedAt);
    io:println("        Associations created: " + batchAssociateResponse.results.length().toString());
    
    // Log details of created associations
    foreach associations:PublicDefaultAssociation createdAssoc in batchAssociateResponse.results {
        io:println("          - Deal " + createdAssoc.'from.id + " → Contact " + createdAssoc.to.id);
        associations:AssociationSpec assocSpec = createdAssoc.associationSpec;
        int? specTypeId = <int?>assocSpec["typeId"];
        string? specCategory = <string?>assocSpec["category"];
        string specTypeIdStr = specTypeId is int ? specTypeId.toString() : "unknown";
        string specCategoryStr = specCategory is string ? specCategory : "unknown";
        io:println("            Type ID: " + specTypeIdStr + 
                  ", Category: " + specCategoryStr);
    }
    
    // Check for any errors during batch creation
    int:Signed32? numErrors = batchAssociateResponse.numErrors;
    if numErrors is int:Signed32 && numErrors > 0 {
        io:println("\n        ⚠ Errors encountered: " + numErrors.toString());
        associations:StandardError[]? errors = batchAssociateResponse.errors;
        if errors is associations:StandardError[] {
            foreach associations:StandardError err in errors {
                io:println("          Error: " + err.message);
            }
        }
    }
    io:println("");

    // Step 3: Verify the associations by retrieving the deal's contact associations
    io:println("Step 3: Verifying deal associations...");
    io:println("        Retrieving all contacts associated with deal " + dealId + "...");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging verificationResponse = 
        check hubspotClient->/objects/deals/[dealId]/associations/contacts();
    
    io:println("        Verified associations found: " + verificationResponse.results.length().toString());
    
    // Display verification results
    string[] verifiedContactIds = [];
    foreach associations:MultiAssociatedObjectWithLabel verifiedContact in verificationResponse.results {
        verifiedContactIds.push(verifiedContact.toObjectId);
        io:println("          ✓ Contact ID: " + verifiedContact.toObjectId);
        foreach associations:AssociationSpecWithLabel assocType in verifiedContact.associationTypes {
            string? labelOpt = assocType.label;
            string labelText = labelOpt is string ? labelOpt : "No label";
            int? verifyTypeId = <int?>assocType["typeId"];
            string? verifyCategory = <string?>assocType["category"];
            string verifyTypeIdStr = verifyTypeId is int ? verifyTypeId.toString() : "unknown";
            string verifyCategoryStr = verifyCategory is string ? verifyCategory : "unknown";
            io:println("            Association: Type ID " + verifyTypeIdStr + 
                      ", Label: " + labelText + ", Category: " + verifyCategoryStr);
        }
    }
    
    // Check for pagination if there are more results
    associations:ForwardPaging? paging = verificationResponse.paging;
    if paging is associations:ForwardPaging {
        associations:NextPage? nextPage = paging.next;
        if nextPage is associations:NextPage {
            io:println("\n        Note: Additional associations exist. Use 'after' cursor: " + nextPage.after);
        }
    }

    // Final validation summary
    io:println("\n=== Workflow Summary ===");
    io:println("Company ID: " + companyId);
    io:println("Deal ID: " + dealId);
    io:println("Original contacts from company: " + contactIds.length().toString());
    io:println("Verified deal-contact associations: " + verifiedContactIds.length().toString());
    
    // Validate that all expected associations were created
    boolean allAssociationsVerified = true;
    foreach string expectedContactId in contactIds {
        boolean found = false;
        foreach string verifiedId in verifiedContactIds {
            if expectedContactId == verifiedId {
                found = true;
                break;
            }
        }
        if !found {
            io:println("⚠ Missing association for contact: " + expectedContactId);
            allAssociationsVerified = false;
        }
    }
    
    if allAssociationsVerified && contactIds.length() > 0 {
        io:println("\n✓ SUCCESS: All company contacts are now properly associated with the deal.");
        io:println("  The customer success team can now access complete contact information for this deal.");
    } else if contactIds.length() == 0 {
        io:println("\n⚠ No associations were created because the company had no contacts.");
    } else {
        io:println("\n⚠ WARNING: Some associations may be missing. Please review the details above.");
    }
    
    io:println("\n=== Customer Onboarding Association Workflow Complete ===");
}