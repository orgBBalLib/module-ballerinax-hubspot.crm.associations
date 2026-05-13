import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string hubspotAccessToken = ?;

public function main() returns error? {
    io:println("=== HubSpot CRM Association Migration Example ===");
    io:println("Synchronizing company-contact associations from staging to production\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: hubspotAccessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    // Step 1: Read existing associations between companies and contacts in batch
    io:println("Step 1: Reading existing company-contact associations in batch...");
    
    // Define the company IDs whose associations we want to read
    associations:BatchInputPublicFetchAssociationsBatchRequest batchReadPayload = {
        inputs: [
            {id: "12345678901"},
            {id: "12345678902"},
            {id: "12345678903"}
        ]
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel|error readResponse = 
        hubspotClient->/associations/["companies"]/["contacts"]/batch/read.post(batchReadPayload);
    
    if readResponse is error {
        io:println("Error reading associations: ", readResponse.message());
        return readResponse;
    }
    
    io:println("Batch read completed with status: ", readResponse.status);
    io:println("Number of results: ", readResponse.results.length());
    
    // Process and display the existing associations
    associations:PublicAssociationMultiPost[] associationsToCreate = [];
    
    foreach associations:PublicAssociationMultiWithLabel result in readResponse.results {
        io:println("\nCompany ID: ", result.'from.id);
        io:println("Associated contacts:");
        
        foreach associations:MultiAssociatedObjectWithLabel associatedContact in result.to {
            io:println("  - Contact ID: ", associatedContact.toObjectId);
            
            // Display association types and labels
            foreach associations:AssociationSpecWithLabel assocType in associatedContact.associationTypes {
                string? labelValue = assocType?.label;
                string labelDisplay = labelValue ?: "No label";
                io:println("    Type ID: ", assocType.typeId, ", Label: ", labelDisplay, ", Category: ", assocType.category);
            }
        }
    }
    
    // Step 2: Create associations in the target system using batch create
    io:println("\n\nStep 2: Creating associations in target system with proper labels...");
    
    // Prepare batch create payload with association labels
    associations:BatchInputPublicAssociationMultiPost batchCreatePayload = {
        inputs: [
            {
                'from: {id: "98765432101"},
                to: {id: "11122233344"},
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 279
                    }
                ]
            },
            {
                'from: {id: "98765432101"},
                to: {id: "11122233355"},
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 280
                    }
                ]
            },
            {
                'from: {id: "98765432102"},
                to: {id: "11122233366"},
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 279
                    }
                ]
            }
        ]
    };
    
    associations:BatchResponseLabelsBetweenObjectPair|error createResponse = 
        hubspotClient->/associations/["companies"]/["contacts"]/batch/create.post(batchCreatePayload);
    
    if createResponse is error {
        io:println("Error creating associations: ", createResponse.message());
        return createResponse;
    }
    
    io:println("Batch create completed with status: ", createResponse.status);
    io:println("Completed at: ", createResponse.completedAt);
    io:println("Number of associations created: ", createResponse.results.length());
    
    // Display created associations
    foreach associations:LabelsBetweenObjectPair createdAssoc in createResponse.results {
        io:println("\nCreated association:");
        io:println("  From Object ID: ", createdAssoc.fromObjectId);
        io:println("  From Object Type ID: ", createdAssoc.fromObjectTypeId);
        io:println("  To Object ID: ", createdAssoc.toObjectId);
        io:println("  To Object Type ID: ", createdAssoc.toObjectTypeId);
        io:println("  Labels: ", createdAssoc.labels);
    }
    
    // Check for any errors during batch creation using member access with type cast
    int? numErrorsValue = <int?>createResponse["numErrors"];
    if numErrorsValue is int && numErrorsValue > 0 {
        io:println("\nWarning: ", numErrorsValue, " errors occurred during batch creation");
        associations:StandardError[]? errorsValue = <associations:StandardError[]?>createResponse["errors"];
        if errorsValue is associations:StandardError[] {
            foreach associations:StandardError err in errorsValue {
                io:println("  Error: ", err.message);
            }
        }
    }
    
    // Step 3: Verify associations by reading back for specific objects
    io:println("\n\nStep 3: Verifying associations were created correctly...");
    
    // Verify associations for the first company
    string verifyCompanyId = "98765432101";
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging|error verifyResponse = 
        hubspotClient->/objects/["companies"]/[verifyCompanyId]/associations/["contacts"].get(
            queries = {'limit: 100}
        );
    
    if verifyResponse is error {
        io:println("Error verifying associations: ", verifyResponse.message());
        return verifyResponse;
    }
    
    io:println("Verification for Company ID: ", verifyCompanyId);
    io:println("Total associated contacts found: ", verifyResponse.results.length());
    
    // Display verified associations
    foreach associations:MultiAssociatedObjectWithLabel verifiedAssoc in verifyResponse.results {
        io:println("\n  Contact ID: ", verifiedAssoc.toObjectId);
        io:println("  Association types:");
        
        foreach associations:AssociationSpecWithLabel assocType in verifiedAssoc.associationTypes {
            string? assocLabelValue = assocType?.label;
            string labelText = assocLabelValue ?: "No label";
            io:println("    - Type ID: ", assocType.typeId);
            io:println("      Label: ", labelText);
            io:println("      Category: ", assocType.category);
        }
    }
    
    // Check for pagination if there are more results using optional field access
    associations:ForwardPaging? pagingValue = verifyResponse?.paging;
    if pagingValue is associations:ForwardPaging {
        associations:NextPage? nextPageValue = pagingValue?.next;
        if nextPageValue is associations:NextPage {
            io:println("\nNote: More associations available. Use 'after' cursor for pagination.");
        }
    }
    
    // Verify associations for the second company
    string verifyCompanyId2 = "98765432102";
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging|error verifyResponse2 = 
        hubspotClient->/objects/["companies"]/[verifyCompanyId2]/associations/["contacts"].get();
    
    if verifyResponse2 is error {
        io:println("Error verifying associations for second company: ", verifyResponse2.message());
        return verifyResponse2;
    }
    
    io:println("\nVerification for Company ID: ", verifyCompanyId2);
    io:println("Total associated contacts found: ", verifyResponse2.results.length());
    
    foreach associations:MultiAssociatedObjectWithLabel verifiedAssoc2 in verifyResponse2.results {
        io:println("  Contact ID: ", verifiedAssoc2.toObjectId);
    }
    
    // Summary
    io:println("\n=== Migration Summary ===");
    io:println("1. Successfully read associations from staging environment");
    io:println("2. Created ", createResponse.results.length(), " associations in target system");
    io:println("3. Verified associations for migrated companies");
    io:println("\nCRM relationship synchronization completed successfully!");
    
    return;
}