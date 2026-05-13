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

    string newCompanyId = "12345678901";
    string salesRepContactId = "98765432101";
    string[] dealIds = ["11111111111", "22222222222", "33333333333"];

    io:println("=== Customer Onboarding Association Management ===\n");

    io:println("Step 1: Creating default association between Company and Sales Rep Contact...");
    
    associations:BatchResponsePublicDefaultAssociation defaultAssociationResponse = 
        check hubspotClient->/objects/["companies"]/[newCompanyId]/associations/default/["contacts"]/[salesRepContactId].put();
    
    io:println("Default association created successfully!");
    io:println("Status: ", defaultAssociationResponse.status);
    io:println("Completed At: ", defaultAssociationResponse.completedAt);
    
    foreach associations:PublicDefaultAssociation result in defaultAssociationResponse.results {
        io:println("  - From Object ID: ", result.'from.id);
        io:println("  - To Object ID: ", result.to.id);
        associations:AssociationSpec associationSpec = result.associationSpec;
        int? typeIdValue = <int?>associationSpec["typeId"];
        if typeIdValue is int {
            io:println("  - Association Type ID: ", typeIdValue);
        }
    }
    io:println();

    io:println("Step 2: Reading existing deal associations for the company...");
    
    associations:BatchInputPublicFetchAssociationsBatchRequest fetchRequest = {
        inputs: [
            {
                id: newCompanyId
            }
        ]
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel existingAssociationsResponse = 
        check hubspotClient->/associations/["companies"]/["deals"]/batch/read.post(payload = fetchRequest);
    
    io:println("Existing associations retrieved successfully!");
    io:println("Status: ", existingAssociationsResponse.status);
    io:println("Started At: ", existingAssociationsResponse.startedAt);
    io:println("Completed At: ", existingAssociationsResponse.completedAt);
    
    foreach associations:PublicAssociationMultiWithLabel result in existingAssociationsResponse.results {
        io:println("  From Object ID: ", result.'from.id);
        associations:MultiAssociatedObjectWithLabel[] toObjects = result.to;
        if toObjects.length() > 0 {
            io:println("  Associated Deals:");
            foreach associations:MultiAssociatedObjectWithLabel toObject in toObjects {
                string toObjectIdValue = toObject.toObjectId.toString();
                io:println("    - Deal ID: ", toObjectIdValue);
                associations:AssociationSpecWithLabel[]? associationTypesValue = toObject.associationTypes;
                if associationTypesValue is associations:AssociationSpecWithLabel[] {
                    foreach associations:AssociationSpecWithLabel assocType in associationTypesValue {
                        int? assocTypeId = <int?>assocType["typeId"];
                        if assocTypeId is int {
                            io:println("      Type ID: ", assocTypeId);
                        }
                        io:println("      Category: ", assocType.category);
                        string? labelValue = assocType?.label;
                        if labelValue is string {
                            io:println("      Label: ", labelValue);
                        }
                    }
                }
            }
        } else {
            io:println("  No existing deal associations found.");
        }
    }
    io:println();

    io:println("Step 3: Creating batch associations with custom labels for deals...");
    
    int:Signed32 primaryDealTypeId = 341;
    int:Signed32 upsellDealTypeId = 342;
    
    associations:PublicAssociationMultiPost[] associationInputs = [
        {
            'from: {
                id: newCompanyId
            },
            to: {
                id: dealIds[0]
            },
            types: [
                {
                    associationCategory: "USER_DEFINED",
                    associationTypeId: primaryDealTypeId
                }
            ]
        },
        {
            'from: {
                id: newCompanyId
            },
            to: {
                id: dealIds[1]
            },
            types: [
                {
                    associationCategory: "USER_DEFINED",
                    associationTypeId: upsellDealTypeId
                }
            ]
        },
        {
            'from: {
                id: newCompanyId
            },
            to: {
                id: dealIds[2]
            },
            types: [
                {
                    associationCategory: "USER_DEFINED",
                    associationTypeId: upsellDealTypeId
                }
            ]
        }
    ];
    
    associations:BatchInputPublicAssociationMultiPost batchCreateRequest = {
        inputs: associationInputs
    };
    
    associations:BatchResponseLabelsBetweenObjectPair batchCreateResponse = 
        check hubspotClient->/associations/["companies"]/["deals"]/batch/create.post(payload = batchCreateRequest);
    
    io:println("Batch associations created successfully!");
    io:println("Status: ", batchCreateResponse.status);
    io:println("Started At: ", batchCreateResponse.startedAt);
    io:println("Completed At: ", batchCreateResponse.completedAt);
    
    io:println("\nCreated Associations:");
    foreach associations:LabelsBetweenObjectPair result in batchCreateResponse.results {
        io:println("  - From Object (Company): ", result.fromObjectId);
        io:println("    To Object (Deal): ", result.toObjectId);
        io:println("    Labels: ", result.labels);
        io:println();
    }
    
    int? numErrorsValue = <int?>batchCreateResponse["numErrors"];
    if numErrorsValue is int && numErrorsValue > 0 {
        io:println("Warning: ", numErrorsValue, " errors occurred during batch processing.");
        associations:StandardError[]? errorsValue = <associations:StandardError[]?>batchCreateResponse["errors"];
        if errorsValue is associations:StandardError[] {
            foreach associations:StandardError err in errorsValue {
                io:println("  Error: ", err.message);
                io:println("  Category: ", err.category);
            }
        }
    }
    
    io:println("\n=== Customer Onboarding Association Management Complete ===");
    io:println("Summary:");
    io:println("  - Company ID: ", newCompanyId);
    io:println("  - Sales Rep Contact ID: ", salesRepContactId);
    io:println("  - Number of Deals Associated: ", dealIds.length());
    io:println("  - Association Categories: Primary Deal, Upsell Opportunity");
}