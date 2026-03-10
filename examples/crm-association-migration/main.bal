import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for source HubSpot environment
configurable string sourceAccessToken = ?;

// Configurable variables for target HubSpot environment
configurable string targetAccessToken = ?;

// Define association type specification for creating associations
type AssociationSpec record {
    int:Signed32 associationTypeId;
    "HUBSPOT_DEFINED"|"INTEGRATOR_DEFINED"|"USER_DEFINED" associationCategory;
};

public function main() returns error? {
    io:println("=== HubSpot CRM Association Migration Tool ===");
    io:println("Synchronizing contact-company relationships between environments\n");

    // Initialize source HubSpot client for reading existing associations
    associations:ConnectionConfig sourceConfig = {
        auth: {
            token: sourceAccessToken
        }
    };
    associations:Client sourceClient = check new (sourceConfig);
    io:println("✓ Connected to source HubSpot environment");

    // Initialize target HubSpot client for creating associations
    associations:ConnectionConfig targetConfig = {
        auth: {
            token: targetAccessToken
        }
    };
    associations:Client targetClient = check new (targetConfig);
    io:println("✓ Connected to target HubSpot environment\n");

    // Define the object types for association migration
    string fromObjectType = "contacts";
    string toObjectType = "companies";

    // Step 1: Read existing associations from source environment
    io:println("Step 1: Reading existing contact-company associations from source...");

    // Prepare batch request to fetch associations for specific contacts
    associations:PublicFetchAssociationsBatchRequest[] fetchInputs = [
        {id: "101"},
        {id: "102"},
        {id: "103"},
        {id: "104"},
        {id: "105"}
    ];

    associations:BatchInputPublicFetchAssociationsBatchRequest batchReadPayload = {
        inputs: fetchInputs
    };

    // Execute batch read to get all associations
    associations:BatchResponsePublicAssociationMultiWithLabel readResponse = 
        check sourceClient->/associations/[fromObjectType]/[toObjectType]/batch/read.post(batchReadPayload);

    io:println("  - Batch read status: ", readResponse.status);
    io:println("  - Completed at: ", readResponse.completedAt);
    io:println("  - Total associations found: ", readResponse.results.length());

    // Check for any errors during read
    int? readNumErrors = <int?>readResponse["numErrors"];
    if readNumErrors is int && readNumErrors > 0 {
        io:println("  - Warning: ", readNumErrors, " errors encountered during read");
        associations:StandardError[]? readErrors = <associations:StandardError[]?>readResponse["errors"];
        if readErrors is associations:StandardError[] {
            foreach associations:StandardError err in readErrors {
                io:println("    Error: ", err.message);
            }
        }
    }

    // Step 2: Process and display the retrieved associations
    io:println("\nStep 2: Processing retrieved association data...");

    // Collect all associations for migration
    associations:PublicAssociationMultiPost[] createInputs = [];

    foreach associations:PublicAssociationMultiWithLabel result in readResponse.results {
        associations:PublicObjectId fromObject = result.'from;
        string fromId = fromObject.id;
        io:println("  Contact ID: ", fromId);

        foreach associations:MultiAssociatedObjectWithLabel toObject in result.to {
            int toIdInt = toObject.toObjectId;
            string toId = toIdInt.toString();
            io:println("    → Associated with Company ID: ", toId);

            // Process each association type
            foreach associations:AssociationSpecWithLabel assocType in toObject.associationTypes {
                int? typeIdValue = assocType?.typeId;
                string? categoryValue = assocType?.category;
                
                if typeIdValue is int && categoryValue is string {
                    io:println("      - Type ID: ", typeIdValue);
                    io:println("      - Category: ", categoryValue);
                    string? labelValue = assocType?.label;
                    if labelValue is string {
                        io:println("      - Label: ", labelValue);
                    }

                    // Build the association spec for recreation in target environment
                    AssociationSpec spec = {
                        associationTypeId: <int:Signed32>typeIdValue,
                        associationCategory: mapCategory(categoryValue)
                    };

                    // Create the association post request
                    associations:PublicAssociationMultiPost assocPost = {
                        'from: {id: fromId},
                        to: {id: toId},
                        types: [spec]
                    };

                    createInputs.push(assocPost);
                }
            }
        }
    }

    io:println("\n  Total associations to migrate: ", createInputs.length());

    // Step 3: Create associations in target environment
    if createInputs.length() > 0 {
        io:println("\nStep 3: Creating associations in target environment...");

        associations:BatchInputPublicAssociationMultiPost batchCreatePayload = {
            inputs: createInputs
        };

        // Execute batch create to replicate associations
        associations:BatchResponseLabelsBetweenObjectPair createResponse = 
            check targetClient->/associations/[fromObjectType]/[toObjectType]/batch/create.post(batchCreatePayload);

        io:println("  - Batch create status: ", createResponse.status);
        io:println("  - Completed at: ", createResponse.completedAt);
        io:println("  - Associations created: ", createResponse.results.length());

        // Check for any errors during creation
        int? createNumErrors = <int?>createResponse["numErrors"];
        if createNumErrors is int && createNumErrors > 0 {
            io:println("  - Warning: ", createNumErrors, " errors encountered during creation");
            associations:StandardError[]? createErrors = <associations:StandardError[]?>createResponse["errors"];
            if createErrors is associations:StandardError[] {
                foreach associations:StandardError err in createErrors {
                    io:println("    Error: ", err.message);
                }
            }
        }

        // Display created associations
        io:println("\n  Created associations summary:");
        foreach associations:LabelsBetweenObjectPair createdAssoc in createResponse.results {
            io:println("    - Contact (", createdAssoc.fromObjectId, ") → Company (", createdAssoc.toObjectId, ")");
            if createdAssoc.labels.length() > 0 {
                io:println("      Labels: ", createdAssoc.labels);
            }
        }
    } else {
        io:println("\nStep 3: No associations to migrate - source had no associations");
    }

    io:println("\n=== Migration Complete ===");
    io:println("Successfully synchronized CRM relationships between HubSpot environments");
}

// Helper function to map association category from source to target format
function mapCategory(string category) returns "HUBSPOT_DEFINED"|"INTEGRATOR_DEFINED"|"USER_DEFINED" {
    match category {
        "HUBSPOT_DEFINED" => {
            return "HUBSPOT_DEFINED";
        }
        "INTEGRATOR_DEFINED" => {
            return "INTEGRATOR_DEFINED";
        }
        "USER_DEFINED" => {
            return "USER_DEFINED";
        }
        _ => {
            return "USER_DEFINED";
        }
    }
}