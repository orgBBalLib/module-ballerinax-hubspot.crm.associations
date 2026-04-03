import ballerina/io;
import ballerinax/hubspot.crm.associations;

configurable string accessToken = ?;

public function main() returns error? {
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    associations:Client hubspotClient = check new (config);

    io:println("=== HubSpot CRM Association Sync: Company-to-Contact Relationships ===\n");

    io:println("Step 1: Reading existing company-to-contact associations...");

    associations:BatchInputPublicFetchAssociationsBatchRequest readPayload = {
        inputs: [
            {id: "12345678901"},
            {id: "12345678902"},
            {id: "12345678903"}
        ]
    };

    associations:BatchResponsePublicAssociationMultiWithLabel readResponse = 
        check hubspotClient->/associations/["companies"]/["contacts"]/batch/read.post(readPayload);

    io:println("Read operation status: ", readResponse.status);
    io:println("Number of results retrieved: ", readResponse.results.length());

    associations:PublicAssociationMultiWithLabel[] retrievedAssociations = readResponse.results;
    
    record {|
        string companyId;
        string contactId;
        int:Signed32 typeId;
        string? label;
        string category;
    |}[] associationMappings = [];

    foreach associations:PublicAssociationMultiWithLabel association in retrievedAssociations {
        associations:PublicObjectId fromObject = association.'from;
        string fromId = fromObject.id;
        io:println("\nCompany ID: ", fromId);
        
        foreach associations:MultiAssociatedObjectWithLabel toObject in association.to {
            int toObjectIdInt = toObject.toObjectId;
            string toObjectId = toObjectIdInt.toString();
            io:println("  -> Contact ID: ", toObjectId);
            
            associations:AssociationSpecWithLabel[]? assocTypesOpt = toObject?.associationTypes;
            associations:AssociationSpecWithLabel[] assocTypes = assocTypesOpt ?: [];
            foreach associations:AssociationSpecWithLabel assocType in assocTypes {
                int:Signed32 typeIdValue = assocType.typeId;
                string? labelValue = assocType?.label;
                string categoryValue = assocType.category;
                io:println("     Type ID: ", typeIdValue);
                io:println("     Label: ", labelValue ?: "No label");
                io:println("     Category: ", categoryValue);
                
                associationMappings.push({
                    companyId: fromId,
                    contactId: toObjectId,
                    typeId: typeIdValue,
                    label: labelValue,
                    category: categoryValue
                });
            }
        }
    }

    io:println("\n--- Data extracted for backup: ", associationMappings.length(), " association mappings ---\n");

    io:println("Step 2: Recreating associations in staging environment...");

    associations:PublicAssociationMultiPost[] createInputs = [];

    foreach var mapping in associationMappings {
        associations:PublicAssociationMultiPost createRequest = {
            'from: {id: mapping.companyId},
            to: {id: mapping.contactId},
            types: [
                {
                    associationCategory: "HUBSPOT_DEFINED",
                    associationTypeId: mapping.typeId
                }
            ]
        };
        createInputs.push(createRequest);
    }

    if createInputs.length() == 0 {
        io:println("No existing associations found. Creating sample test associations...");
        createInputs = [
            {
                'from: {id: "12345678901"},
                to: {id: "98765432101"},
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 280
                    }
                ]
            },
            {
                'from: {id: "12345678902"},
                to: {id: "98765432102"},
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 280
                    }
                ]
            }
        ];
    }

    associations:BatchInputPublicAssociationMultiPost createPayload = {
        inputs: createInputs
    };

    associations:BatchResponseLabelsBetweenObjectPair createResponse = 
        check hubspotClient->/associations/["companies"]/["contacts"]/batch/create.post(createPayload);

    io:println("Create operation status: ", createResponse.status);
    io:println("Associations created: ", createResponse.results.length());

    foreach associations:LabelsBetweenObjectPair createdAssoc in createResponse.results {
        io:println("  Created: Company ", createdAssoc.fromObjectId, " -> Contact ", createdAssoc.toObjectId);
        if createdAssoc.labels.length() > 0 {
            io:println("    Labels: ", createdAssoc.labels);
        }
    }

    int? createNumErrors = <int?>createResponse["numErrors"];
    if createNumErrors is int && createNumErrors > 0 {
        io:println("  Warning: ", createNumErrors, " errors occurred during creation");
        associations:StandardError[]? createErrors = <associations:StandardError[]?>createResponse["errors"];
        if createErrors is associations:StandardError[] {
            foreach associations:StandardError err in createErrors {
                io:println("    Error: ", err.message);
            }
        }
    }

    io:println("\n--- Associations recreated in staging environment ---\n");

    io:println("Step 3: Cleaning up test associations (batch archive)...");

    associations:PublicAssociationMultiArchive[] archiveInputs = [];

    associations:PublicAssociationMultiArchive archiveRequest1 = {
        'from: {id: "12345678901"},
        to: [
            {id: "98765432101"}
        ]
    };
    archiveInputs.push(archiveRequest1);

    associations:PublicAssociationMultiArchive archiveRequest2 = {
        'from: {id: "12345678902"},
        to: [
            {id: "98765432102"}
        ]
    };
    archiveInputs.push(archiveRequest2);

    associations:BatchInputPublicAssociationMultiArchive archivePayload = {
        inputs: archiveInputs
    };

    error? archiveResult = 
        hubspotClient->/associations/["companies"]/["contacts"]/batch/archive.post(archivePayload);

    if archiveResult is error {
        io:println("Archive operation failed: ", archiveResult.message());
    } else {
        io:println("Archive operation status code: 204");
        io:println("  Test associations successfully archived");
    }

    io:println("\n=== CRM Association Sync Complete ===");
    io:println("Summary:");
    io:println("  - Associations read: ", retrievedAssociations.length(), " companies processed");
    io:println("  - Association mappings extracted: ", associationMappings.length());
    io:println("  - Associations created in staging: ", createResponse.results.length());
    io:println("  - Test associations archived: ", archiveInputs.length(), " archive requests processed");
    io:println("\nThe system is now ready for final migration.");
}