import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Custom association type IDs for labeled associations
// These would be pre-configured in HubSpot for your organization
const int:Signed32 DECISION_MAKER_LABEL_ID = 1;
const int:Signed32 TECHNICAL_CONTACT_LABEL_ID = 2;

public function main() returns error? {
    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("=== Customer Onboarding Association Workflow ===");
    io:println("Processing closed-won deal associations...\n");
    
    // Sample deal ID that was just marked as closed-won
    string closedWonDealId = "12345678";
    
    // Sample company ID (primary company for this deal)
    string primaryCompanyId = "98765432";
    
    // Sample contact IDs related to this deal
    string decisionMakerContactId = "11111111";
    string technicalContactId = "22222222";
    string additionalContactId = "33333333";
    
    // ========================================
    // Step 1: Read existing associations between deal and contacts
    // ========================================
    io:println("Step 1: Reading existing associations between deal and contacts...");
    
    associations:BatchInputPublicFetchAssociationsBatchRequest readAssociationsPayload = {
        inputs: [
            {
                id: closedWonDealId
            }
        ]
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel existingAssociationsResponse = 
        check hubspotClient->/associations/["deals"]/["contacts"]/batch/read.post(readAssociationsPayload);
    
    io:println("Existing associations fetch status: ", existingAssociationsResponse.status);
    
    // Process and display existing associations
    string[] existingContactIds = [];
    foreach associations:PublicAssociationMultiWithLabel result in existingAssociationsResponse.results {
        io:println("Deal ID: ", result.'from.id);
        foreach associations:MultiAssociatedObjectWithLabel toObject in result.to {
            string toObjectIdValue = toObject.toObjectId.toString();
            existingContactIds.push(toObjectIdValue);
            io:println("  - Associated Contact ID: ", toObjectIdValue);
            foreach associations:AssociationSpecWithLabel assocType in toObject.associationTypes {
                string? labelValue = assocType?.label;
                string labelText = labelValue ?: "No label";
                io:println("    Label: ", labelText, " | Category: ", assocType.category);
            }
        }
    }
    
    io:println("\nFound ", existingContactIds.length(), " existing contact associations.\n");
    
    // ========================================
    // Step 2: Create batch associations linking deal to company using default association types
    // ========================================
    io:println("Step 2: Creating default association between deal and primary company...");
    
    associations:BatchInputPublicDefaultAssociationMultiPost defaultAssociationPayload = {
        inputs: [
            {
                'from: {
                    id: closedWonDealId
                },
                to: {
                    id: primaryCompanyId
                }
            }
        ]
    };
    
    associations:BatchResponsePublicDefaultAssociation defaultAssociationResponse = 
        check hubspotClient->/associations/["deals"]/["companies"]/batch/associate/default.post(defaultAssociationPayload);
    
    io:println("Default association creation status: ", defaultAssociationResponse.status);
    io:println("Created ", defaultAssociationResponse.results.length(), " default association(s).");
    
    foreach associations:PublicDefaultAssociation result in defaultAssociationResponse.results {
        io:println("  - Deal ", result.'from.id, " -> Company ", result.to.id);
        associations:AssociationSpec assocSpec = result.associationSpec;
        int:Signed32? typeIdValue = <int:Signed32?>assocSpec["typeId"];
        string? categoryValue = <string?>assocSpec["category"];
        io:println("    Association Type ID: ", typeIdValue);
        io:println("    Category: ", categoryValue);
    }
    
    // Check for any errors in the batch operation
    int:Signed32? defaultNumErrors = <int:Signed32?>defaultAssociationResponse["numErrors"];
    if defaultNumErrors is int:Signed32 && defaultNumErrors > 0 {
        io:println("  Warning: ", defaultNumErrors, " error(s) occurred during association creation.");
        associations:StandardError[]? errors = <associations:StandardError[]?>defaultAssociationResponse["errors"];
        if errors is associations:StandardError[] {
            foreach associations:StandardError err in errors {
                io:println("    Error: ", err.message);
            }
        }
    }
    
    io:println("\n");
    
    // ========================================
    // Step 3: Create labeled associations between deal and contacts
    // ========================================
    io:println("Step 3: Creating labeled associations between deal and contacts...");
    io:println("Adding relationship context for sales-to-customer-success handoff...\n");
    
    // Define association specs for different contact roles
    associations:AssociationSpec decisionMakerSpec = {
        associationCategory: "USER_DEFINED",
        associationTypeId: DECISION_MAKER_LABEL_ID
    };
    
    associations:AssociationSpec technicalContactSpec = {
        associationCategory: "USER_DEFINED",
        associationTypeId: TECHNICAL_CONTACT_LABEL_ID
    };
    
    // Default deal-to-contact association type (HubSpot defined)
    associations:AssociationSpec defaultContactSpec = {
        associationCategory: "HUBSPOT_DEFINED",
        associationTypeId: 3
    };
    
    // Create batch payload for labeled associations
    associations:BatchInputPublicAssociationMultiPost labeledAssociationPayload = {
        inputs: [
            // Decision Maker contact with custom label
            {
                'from: {
                    id: closedWonDealId
                },
                to: {
                    id: decisionMakerContactId
                },
                types: [decisionMakerSpec]
            },
            // Technical Contact with custom label
            {
                'from: {
                    id: closedWonDealId
                },
                to: {
                    id: technicalContactId
                },
                types: [technicalContactSpec]
            },
            // Additional contact with default association
            {
                'from: {
                    id: closedWonDealId
                },
                to: {
                    id: additionalContactId
                },
                types: [defaultContactSpec]
            }
        ]
    };
    
    associations:BatchResponseLabelsBetweenObjectPair labeledAssociationResponse = 
        check hubspotClient->/associations/["deals"]/["contacts"]/batch/create.post(labeledAssociationPayload);
    
    io:println("Labeled association creation status: ", labeledAssociationResponse.status);
    io:println("Processing completed at: ", labeledAssociationResponse.completedAt);
    io:println("Created ", labeledAssociationResponse.results.length(), " labeled association(s).\n");
    
    // Display the created labeled associations
    foreach associations:LabelsBetweenObjectPair result in labeledAssociationResponse.results {
        io:println("Association Created:");
        io:println("  From Object ID: ", result.fromObjectId, " (Type: ", result.fromObjectTypeId, ")");
        io:println("  To Object ID: ", result.toObjectId, " (Type: ", result.toObjectTypeId, ")");
        io:println("  Labels: ", result.labels);
        io:println("");
    }
    
    // Check for any errors in the labeled associations batch
    int:Signed32? labeledNumErrors = <int:Signed32?>labeledAssociationResponse["numErrors"];
    if labeledNumErrors is int:Signed32 && labeledNumErrors > 0 {
        io:println("Warning: ", labeledNumErrors, " error(s) occurred during labeled association creation.");
        associations:StandardError[]? labeledErrors = <associations:StandardError[]?>labeledAssociationResponse["errors"];
        if labeledErrors is associations:StandardError[] {
            foreach associations:StandardError err in labeledErrors {
                io:println("  Error: ", err.message, " | Category: ", err.category);
            }
        }
    }
    
    // ========================================
    // Summary
    // ========================================
    io:println("=== Workflow Complete ===");
    io:println("Customer onboarding association workflow completed successfully!");
    io:println("Summary:");
    io:println("  - Deal ID: ", closedWonDealId);
    io:println("  - Primary Company Association: Created (ID: ", primaryCompanyId, ")");
    io:println("  - Decision Maker Contact: ", decisionMakerContactId);
    io:println("  - Technical Contact: ", technicalContactId);
    io:println("  - Additional Contact: ", additionalContactId);
    io:println("\nThe sales team can now hand off to customer success with full relationship context.");
}