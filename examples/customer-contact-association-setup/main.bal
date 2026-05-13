import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample company ID representing the new enterprise customer
configurable string companyId = "12345678901";

// Sample contact IDs representing different stakeholders
configurable string primaryContactId = "98765432101";
configurable string technicalLeadId = "98765432102";
configurable string billingContactId = "98765432103";

// Association type IDs for company to contact relationships
// These are HubSpot-defined association types
const int:Signed32 COMPANY_TO_CONTACT_PRIMARY = 1;
const int:Signed32 COMPANY_TO_CONTACT_UNLABELED = 279;

public function main() returns error? {
    io:println("=== Customer Onboarding Association Management ===\n");
    
    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("Step 1: Checking for existing associations between company and contacts...\n");
    
    // Step 1: Read existing associations to check for pre-existing relationships
    associations:BatchInputPublicFetchAssociationsBatchRequest readRequest = {
        inputs: [
            {
                id: companyId
            }
        ]
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel|error existingAssociations = 
        hubspotClient->/associations/["companies"]/["contacts"]/batch/read.post(readRequest);
    
    if existingAssociations is error {
        io:println("Note: No existing associations found or error reading associations.");
        io:println("Proceeding with creating new associations...\n");
    } else {
        io:println("Existing associations found:");
        io:println("Status: ", existingAssociations.status);
        io:println("Number of results: ", existingAssociations.results.length());
        
        foreach associations:PublicAssociationMultiWithLabel result in existingAssociations.results {
            io:println("  From Object ID: ", result.'from.id);
            foreach associations:MultiAssociatedObjectWithLabel toObj in result.to {
                io:println("    -> Associated Contact ID: ", toObj.toObjectId);
                foreach associations:AssociationSpecWithLabel assocType in toObj.associationTypes {
                    string? labelValue = assocType?.label;
                    string labelDisplay = labelValue ?: "No Label";
                    io:println("       Label: ", labelDisplay, ", Category: ", assocType.category);
                }
            }
        }
        io:println();
    }
    
    io:println("Step 2: Creating batch associations with specific labels...\n");
    
    // Step 2: Create batch associations with specific labels for different contact roles
    // Preparing association requests for Primary Contact, Technical Lead, and Billing Contact
    associations:BatchInputPublicAssociationMultiPost createRequest = {
        inputs: [
            // Primary Contact association
            {
                'from: {
                    id: companyId
                },
                to: {
                    id: primaryContactId
                },
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: COMPANY_TO_CONTACT_PRIMARY
                    }
                ]
            },
            // Technical Lead association
            {
                'from: {
                    id: companyId
                },
                to: {
                    id: technicalLeadId
                },
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: COMPANY_TO_CONTACT_UNLABELED
                    }
                ]
            },
            // Billing Contact association
            {
                'from: {
                    id: companyId
                },
                to: {
                    id: billingContactId
                },
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: COMPANY_TO_CONTACT_UNLABELED
                    }
                ]
            }
        ]
    };
    
    associations:BatchResponseLabelsBetweenObjectPair createResponse = 
        check hubspotClient->/associations/["companies"]/["contacts"]/batch/create.post(createRequest);
    
    io:println("Batch association creation completed:");
    io:println("Status: ", createResponse.status);
    io:println("Started at: ", createResponse.startedAt);
    io:println("Completed at: ", createResponse.completedAt);
    
    int:Signed32? numErrorsValue = <int:Signed32?>createResponse["numErrors"];
    if numErrorsValue is int:Signed32 {
        io:println("Number of errors: ", numErrorsValue);
    }
    
    io:println("\nCreated associations:");
    foreach associations:LabelsBetweenObjectPair result in createResponse.results {
        io:println("  Company (", result.fromObjectId, ") -> Contact (", result.toObjectId, ")");
        io:println("    Labels: ", result.labels);
    }
    
    associations:StandardError[]? errorsValue = <associations:StandardError[]?>createResponse["errors"];
    if errorsValue is associations:StandardError[] {
        io:println("\nErrors encountered:");
        foreach associations:StandardError err in errorsValue {
            io:println("  Error: ", err.message);
            io:println("  Category: ", err.category);
        }
    }
    
    io:println("\nStep 3: Retrieving updated association list for onboarding dashboard...\n");
    
    // Step 3: Retrieve the updated association list to confirm all relationships
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging updatedAssociations = 
        check hubspotClient->/objects/["companies"]/[companyId]/associations/["contacts"]();
    
    io:println("=== Onboarding Dashboard - Company Associations ===");
    io:println("Company ID: ", companyId);
    io:println("Total associated contacts: ", updatedAssociations.results.length());
    io:println();
    
    io:println("Associated Contacts:");
    io:println("--------------------");
    
    foreach associations:MultiAssociatedObjectWithLabel contact in updatedAssociations.results {
        io:println("Contact ID: ", contact.toObjectId);
        
        foreach associations:AssociationSpecWithLabel assocType in contact.associationTypes {
            string? roleLabelValue = assocType?.label;
            string roleLabel = roleLabelValue ?: "Standard Contact";
            io:println("  - Role: ", roleLabel);
            io:println("    Type ID: ", assocType.typeId);
            io:println("    Category: ", assocType.category);
        }
        io:println();
    }
    
    // Check for pagination if there are more results
    associations:ForwardPaging? pagingValue = updatedAssociations?.paging;
    if pagingValue is associations:ForwardPaging {
        associations:NextPage? nextPageValue = pagingValue?.next;
        if nextPageValue is associations:NextPage {
            io:println("Note: More associations available. Next page cursor: ", nextPageValue.after);
        }
    }
    
    io:println("=== Customer Onboarding Association Setup Complete ===");
    io:println("All relationships have been established for the enterprise customer.");
}