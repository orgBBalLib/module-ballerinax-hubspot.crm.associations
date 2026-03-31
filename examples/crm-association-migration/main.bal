import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Custom association type IDs for labeled relationships
// These would typically be obtained from HubSpot's association schema API
// or created as custom association labels in HubSpot settings
const int:Signed32 PRIMARY_DECISION_MAKER_TYPE_ID = 1;
const int:Signed32 TECHNICAL_CONTACT_TYPE_ID = 2;

public function main() returns error? {
    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("=== CRM Relationship Data Migration ===");
    io:println("Starting migration of contact-to-company associations...\n");

    // Step 1: Batch read existing contact-to-company associations
    // These contact IDs represent contacts that need their relationships restructured
    // after the company reorganization
    string[] contactIds = ["101", "102", "103", "104", "105"];
    
    io:println("Step 1: Reading existing contact-to-company associations...");
    
    // Prepare the batch read request
    associations:PublicFetchAssociationsBatchRequest[] fetchRequests = [];
    foreach string contactId in contactIds {
        associations:PublicFetchAssociationsBatchRequest fetchRequest = {
            id: contactId
        };
        fetchRequests.push(fetchRequest);
    }
    
    associations:BatchInputPublicFetchAssociationsBatchRequest batchReadPayload = {
        inputs: fetchRequests
    };
    
    // Execute batch read to get existing associations
    associations:BatchResponsePublicAssociationMultiWithLabel readResponse = 
        check hubspotClient->/associations/["contacts"]/["companies"]/batch/read.post(batchReadPayload);
    
    io:println("Batch read status: " + readResponse.status);
    io:println("Completed at: " + readResponse.completedAt);
    int resultsLength = readResponse.results.length();
    io:println("Number of results: " + resultsLength.toString());
    
    // Process and display existing associations
    io:println("\nExisting Contact-Company Associations:");
    io:println("--------------------------------------");
    
    // Store existing relationships for analysis and migration planning
    map<string[]> existingRelationships = {};
    
    foreach associations:PublicAssociationMultiWithLabel result in readResponse.results {
        string fromContactId = result.'from.id;
        string[] associatedCompanies = [];
        
        foreach associations:MultiAssociatedObjectWithLabel toObject in result.to {
            associatedCompanies.push(toObject.toObjectId);
            
            // Display existing association types/labels
            string labels = "";
            foreach associations:AssociationSpecWithLabel assocType in toObject.associationTypes {
                string? labelOpt = assocType?.label;
                string labelText = labelOpt ?: "No Label";
                int:Signed32 typeIdValue = assocType.typeId;
                labels = labels + labelText + " (TypeID: " + typeIdValue.toString() + "), ";
            }
            
            io:println("Contact " + fromContactId + " -> Company " + toObject.toObjectId + 
                       " | Labels: " + labels);
        }
        
        existingRelationships[fromContactId] = associatedCompanies;
    }
    
    // Check for any errors in the read operation
    int:Signed32? readNumErrors = <int:Signed32?>readResponse["numErrors"];
    if readNumErrors is int:Signed32 && readNumErrors > 0 {
        io:println("\nWarning: " + readNumErrors.toString() + " errors occurred during batch read.");
        associations:StandardError[]? errors = <associations:StandardError[]?>readResponse["errors"];
        if errors is associations:StandardError[] {
            foreach associations:StandardError err in errors {
                io:println("  Error: " + err.message + " (Category: " + err.category + ")");
            }
        }
    }
    
    io:println("\n==============================================\n");
    
    // Step 2: Create new associations with custom labels based on business rules
    // After company reorganization, we need to categorize contacts with specific roles
    io:println("Step 2: Creating new associations with custom labels...");
    io:println("Applying new relationship labels based on reorganization rules...\n");
    
    // Define the new associations with custom labels
    // These represent the restructured relationships after company reorganization
    associations:PublicAssociationMultiPost[] newAssociations = [];
    
    // Contact 101 is now the Primary Decision Maker for Company 201
    associations:PublicAssociationMultiPost association1 = {
        'from: {
            id: "101"
        },
        to: {
            id: "201"
        },
        types: [
            {
                associationCategory: "USER_DEFINED",
                associationTypeId: PRIMARY_DECISION_MAKER_TYPE_ID
            }
        ]
    };
    newAssociations.push(association1);
    
    // Contact 102 is now the Technical Contact for Company 201
    associations:PublicAssociationMultiPost association2 = {
        'from: {
            id: "102"
        },
        to: {
            id: "201"
        },
        types: [
            {
                associationCategory: "USER_DEFINED",
                associationTypeId: TECHNICAL_CONTACT_TYPE_ID
            }
        ]
    };
    newAssociations.push(association2);
    
    // Contact 103 is the Primary Decision Maker for Company 202
    associations:PublicAssociationMultiPost association3 = {
        'from: {
            id: "103"
        },
        to: {
            id: "202"
        },
        types: [
            {
                associationCategory: "USER_DEFINED",
                associationTypeId: PRIMARY_DECISION_MAKER_TYPE_ID
            }
        ]
    };
    newAssociations.push(association3);
    
    // Contact 104 is both Primary Decision Maker and Technical Contact for Company 203
    // This demonstrates a contact with multiple roles
    associations:PublicAssociationMultiPost association4 = {
        'from: {
            id: "104"
        },
        to: {
            id: "203"
        },
        types: [
            {
                associationCategory: "USER_DEFINED",
                associationTypeId: PRIMARY_DECISION_MAKER_TYPE_ID
            },
            {
                associationCategory: "USER_DEFINED",
                associationTypeId: TECHNICAL_CONTACT_TYPE_ID
            }
        ]
    };
    newAssociations.push(association4);
    
    // Contact 105 is the Technical Contact for Company 204
    associations:PublicAssociationMultiPost association5 = {
        'from: {
            id: "105"
        },
        to: {
            id: "204"
        },
        types: [
            {
                associationCategory: "USER_DEFINED",
                associationTypeId: TECHNICAL_CONTACT_TYPE_ID
            }
        ]
    };
    newAssociations.push(association5);
    
    // Prepare the batch create payload
    associations:BatchInputPublicAssociationMultiPost batchCreatePayload = {
        inputs: newAssociations
    };
    
    // Execute batch create to establish new labeled associations
    associations:BatchResponseLabelsBetweenObjectPair createResponse = 
        check hubspotClient->/associations/["contacts"]/["companies"]/batch/create.post(batchCreatePayload);
    
    io:println("Batch create status: " + createResponse.status);
    io:println("Completed at: " + createResponse.completedAt);
    int createResultsLength = createResponse.results.length();
    io:println("Number of associations created: " + createResultsLength.toString());
    
    // Display the newly created associations
    io:println("\nNewly Created Labeled Associations:");
    io:println("------------------------------------");
    
    foreach associations:LabelsBetweenObjectPair result in createResponse.results {
        string labelsStr = "";
        foreach string label in result.labels {
            labelsStr = labelsStr + label + ", ";
        }
        
        io:println("Contact " + result.fromObjectId.toString() + " -> Company " + result.toObjectId.toString() + 
                   " | Labels: " + labelsStr);
    }
    
    // Check for any errors in the create operation
    int:Signed32? createNumErrors = <int:Signed32?>createResponse["numErrors"];
    if createNumErrors is int:Signed32 && createNumErrors > 0 {
        io:println("\nWarning: " + createNumErrors.toString() + " errors occurred during batch create.");
        associations:StandardError[]? createErrors = <associations:StandardError[]?>createResponse["errors"];
        if createErrors is associations:StandardError[] {
            foreach associations:StandardError err in createErrors {
                io:println("  Error: " + err.message + " (Category: " + err.category + ")");
            }
        }
    }
    
    io:println("\n==============================================");
    io:println("CRM Relationship Data Migration Complete!");
    io:println("==============================================");
    io:println("\nSummary:");
    io:println("  - Existing associations read: " + resultsLength.toString());
    io:println("  - New labeled associations created: " + createResultsLength.toString());
    io:println("\nSales teams can now use the following labels for targeting:");
    io:println("  - 'Primary Decision Maker' - Key contacts for deal negotiations");
    io:println("  - 'Technical Contact' - Contacts for technical discussions and demos");
}