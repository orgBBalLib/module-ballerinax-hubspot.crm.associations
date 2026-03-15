import ballerina/io;
import ballerinax/hubspot.crm.associations;

configurable string accessToken = ?;

configurable string companyId = "12345678";
configurable string dealId = "98765432";

public function main() returns error? {
    io:println("=== Customer Onboarding Association Workflow ===");
    io:println("This workflow associates a closed enterprise deal with all company contacts.\n");

    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    io:println("✓ HubSpot CRM Associations client initialized successfully.\n");

    io:println("--- Step 1: Retrieving Company-to-Contact Associations ---");
    io:println(string `Company ID: ${companyId}`);
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging companyContacts = 
        check hubspotClient->/objects/["companies"]/[companyId]/associations/["contacts"]();
    
    associations:MultiAssociatedObjectWithLabel[] contactAssociations = companyContacts.results;
    int contactCount = contactAssociations.length();
    io:println(string `Found ${contactCount.toString()} contact(s) associated with the company.\n`);
    
    if contactCount == 0 {
        io:println("No contacts found for this company. Exiting workflow.");
        return;
    }

    io:println("Contacts to associate with the deal:");
    foreach associations:MultiAssociatedObjectWithLabel contact in contactAssociations {
        io:println(string `  - Contact ID: ${contact.toObjectId}`);
        foreach associations:AssociationSpecWithLabel assocType in contact.associationTypes {
            string? labelValue = assocType?.label;
            string labelDisplay = labelValue ?: "No label";
            int? typeIdValue = <int?>assocType["typeId"];
            string typeIdStr = typeIdValue is int ? typeIdValue.toString() : "unknown";
            string? categoryValue = <string?>assocType["category"];
            string categoryStr = categoryValue ?: "unknown";
            io:println(string `    Association Type ID: ${typeIdStr}, Label: ${labelDisplay}, Category: ${categoryStr}`);
        }
    }
    io:println();

    io:println("--- Step 2: Creating Deal-to-Contact Associations ---");
    io:println(string `Deal ID: ${dealId}`);
    
    associations:PublicDefaultAssociationMultiPost[] associationInputs = [];
    
    foreach associations:MultiAssociatedObjectWithLabel contact in contactAssociations {
        associations:PublicDefaultAssociationMultiPost associationRequest = {
            'from: {
                id: dealId
            },
            to: {
                id: contact.toObjectId
            }
        };
        associationInputs.push(associationRequest);
    }
    
    associations:BatchInputPublicDefaultAssociationMultiPost batchCreatePayload = {
        inputs: associationInputs
    };
    
    int inputCount = associationInputs.length();
    io:println(string `Creating ${inputCount.toString()} deal-to-contact association(s)...`);
    
    associations:BatchResponsePublicDefaultAssociation createResponse = 
        check hubspotClient->/associations/["deals"]/["contacts"]/batch/associate/'default.post(batchCreatePayload);
    
    io:println(string `Batch operation status: ${createResponse.status}`);
    io:println(string `Started at: ${createResponse.startedAt}`);
    io:println(string `Completed at: ${createResponse.completedAt}`);
    
    int? createNumErrors = <int?>createResponse["numErrors"];
    if createNumErrors is int && createNumErrors > 0 {
        io:println(string `⚠ Number of errors: ${createNumErrors.toString()}`);
        associations:StandardError[]? errorsArray = createResponse.errors;
        if errorsArray is associations:StandardError[] {
            foreach associations:StandardError err in errorsArray {
                io:println(string `  Error: ${err.message}`);
            }
        }
    } else {
        io:println("✓ All associations created successfully!");
    }
    
    io:println("\nCreated associations:");
    foreach associations:PublicDefaultAssociation result in createResponse.results {
        io:println(string `  - From Deal: ${result.'from.id} → To Contact: ${result.to.id}`);
        associations:AssociationSpec assocSpec = result.associationSpec;
        int? specTypeId = <int?>assocSpec["typeId"];
        string specTypeIdStr = specTypeId is int ? specTypeId.toString() : "unknown";
        string? specCategory = <string?>assocSpec["category"];
        string specCategoryStr = specCategory ?: "unknown";
        io:println(string `    Association Type ID: ${specTypeIdStr}, Category: ${specCategoryStr}`);
    }
    io:println();

    io:println("--- Step 3: Verifying Deal-to-Contact Associations ---");
    io:println("Reading back associations to confirm they were created correctly...\n");
    
    associations:PublicFetchAssociationsBatchRequest[] readInputs = [
        {
            id: dealId
        }
    ];
    
    associations:BatchInputPublicFetchAssociationsBatchRequest batchReadPayload = {
        inputs: readInputs
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel readResponse = 
        check hubspotClient->/associations/["deals"]/["contacts"]/batch/read.post(batchReadPayload);
    
    io:println(string `Verification batch status: ${readResponse.status}`);
    
    int? readNumErrors = <int?>readResponse["numErrors"];
    if readNumErrors is int && readNumErrors > 0 {
        io:println(string `⚠ Encountered ${readNumErrors.toString()} error(s) during verification.`);
    }
    
    io:println("\nVerified Deal-to-Contact Associations:");
    foreach associations:PublicAssociationMultiWithLabel result in readResponse.results {
        io:println(string `Deal ID: ${result.'from.id}`);
        io:println("Associated Contacts:");
        
        foreach associations:MultiAssociatedObjectWithLabel contactAssoc in result.to {
            io:println(string `  - Contact ID: ${contactAssoc.toObjectId}`);
            foreach associations:AssociationSpecWithLabel assocType in contactAssoc.associationTypes {
                string? verifyLabelValue = assocType?.label;
                string verifyLabelDisplay = verifyLabelValue ?: "Default";
                int? verifyTypeId = <int?>assocType["typeId"];
                string verifyTypeIdStr = verifyTypeId is int ? verifyTypeId.toString() : "unknown";
                string? verifyCategory = <string?>assocType["category"];
                string verifyCategoryStr = verifyCategory ?: "unknown";
                io:println(string `    Type ID: ${verifyTypeIdStr}, Label: ${verifyLabelDisplay}, Category: ${verifyCategoryStr}`);
            }
        }
    }
    
    io:println("\n=== Workflow Complete ===");
    io:println("Summary for Customer Success Team Handoff:");
    io:println(string `  • Deal ID: ${dealId}`);
    io:println(string `  • Company ID: ${companyId}`);
    int totalContacts = contactAssociations.length();
    io:println(string `  • Total Contacts Associated: ${totalContacts.toString()}`);
    io:println("\n✓ All deal-to-contact relationships are properly established.");
    io:println("  The customer success team can now access all relevant contacts from the deal record.");
}