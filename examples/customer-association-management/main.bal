import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample CRM object IDs for demonstration
// In a real scenario, these would be obtained from company/contact creation APIs
const string NEW_COMPANY_ID = "12345678901";
const string SALES_REP_CONTACT_ID = "98765432101";
const string DECISION_MAKER_CONTACT_ID = "11122233344";
const string TECHNICAL_CONTACT_ID = "55566677788";
const string BILLING_CONTACT_ID = "99988877766";

// HubSpot association type IDs for company-to-contact associations
// These are standard HubSpot-defined type IDs
const int:Signed32 PRIMARY_CONTACT_TYPE_ID = 279;
const int:Signed32 DECISION_MAKER_TYPE_ID = 280;
const int:Signed32 TECHNICAL_CONTACT_TYPE_ID = 281;

public function main() returns error? {
    io:println("=== Customer Onboarding Association Management ===\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    io:println("✓ HubSpot CRM Associations client initialized successfully\n");

    // Step 1: Create default association between new company and assigned sales representative
    io:println("--- Step 1: Creating Default Association ---");
    io:println("Linking new company to assigned sales representative...");
    
    associations:BatchResponsePublicDefaultAssociation defaultAssociationResponse = 
        check hubspotClient->/objects/["companies"]/[NEW_COMPANY_ID]/associations/default/["contacts"]/[SALES_REP_CONTACT_ID].put();
    
    io:println("Default association created successfully!");
    io:println("Status: " + defaultAssociationResponse.status);
    io:println("Completed at: " + defaultAssociationResponse.completedAt);
    
    if defaultAssociationResponse.results.length() > 0 {
        io:println("Association details:");
        foreach associations:PublicDefaultAssociation result in defaultAssociationResponse.results {
            io:println("  - From Object ID: " + result.'from.id);
            io:println("  - To Object ID: " + result.to.id);
            int:Signed32? typeIdValue = <int:Signed32?>result.associationSpec["typeId"];
            string typeIdStr = typeIdValue is int:Signed32 ? typeIdValue.toString() : "unknown";
            io:println("  - Association Type ID: " + typeIdStr);
        }
    }
    io:println();

    // Step 2: Batch read all existing associations for the company to verify relationships
    io:println("--- Step 2: Reading All Company Associations ---");
    io:println("Fetching all contact associations for the company...");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging existingAssociations = 
        check hubspotClient->/objects/["companies"]/[NEW_COMPANY_ID]/associations/["contacts"].get(
            queries = {
                'limit: 100
            }
        );
    
    io:println("Successfully retrieved company associations!");
    int resultsLength = existingAssociations.results.length();
    io:println("Number of associated contacts: " + resultsLength.toString());
    
    if existingAssociations.results.length() > 0 {
        io:println("\nExisting associations:");
        foreach associations:MultiAssociatedObjectWithLabel association in existingAssociations.results {
            int? toObjectIdValue = association.toObjectId;
            string toObjectIdStr = toObjectIdValue is int ? toObjectIdValue.toString() : "unknown";
            io:println("  Contact ID: " + toObjectIdStr);
            io:println("  Association Types:");
            foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
                string? labelValue = assocType.label;
                string labelDisplay = labelValue is string ? labelValue : "No label";
                io:println("    - Type ID: " + assocType.typeId.toString() + 
                          ", Label: " + labelDisplay + 
                          ", Category: " + assocType.category);
            }
        }
    }
    
    // Check for pagination
    associations:ForwardPaging? pagingValue = existingAssociations.paging;
    if pagingValue is associations:ForwardPaging {
        associations:NextPage? nextPageValue = pagingValue.next;
        if nextPageValue is associations:NextPage {
            io:println("\nNote: Additional pages of results available");
        }
    }
    io:println();

    // Step 3: Create custom labeled associations using batch operations
    io:println("--- Step 3: Creating Custom Labeled Associations (Batch) ---");
    io:println("Creating labeled associations for stakeholder contacts...");
    
    // Prepare batch input for creating multiple labeled associations
    associations:BatchInputPublicAssociationMultiPost batchInput = {
        inputs: [
            // Primary Decision Maker association
            {
                'from: {
                    id: NEW_COMPANY_ID
                },
                to: {
                    id: DECISION_MAKER_CONTACT_ID
                },
                types: [
                    {
                        associationCategory: "USER_DEFINED",
                        associationTypeId: DECISION_MAKER_TYPE_ID
                    }
                ]
            },
            // Technical Contact association
            {
                'from: {
                    id: NEW_COMPANY_ID
                },
                to: {
                    id: TECHNICAL_CONTACT_ID
                },
                types: [
                    {
                        associationCategory: "USER_DEFINED",
                        associationTypeId: TECHNICAL_CONTACT_TYPE_ID
                    }
                ]
            },
            // Billing Contact association (using primary contact type)
            {
                'from: {
                    id: NEW_COMPANY_ID
                },
                to: {
                    id: BILLING_CONTACT_ID
                },
                types: [
                    {
                        associationCategory: "USER_DEFINED",
                        associationTypeId: PRIMARY_CONTACT_TYPE_ID
                    }
                ]
            }
        ]
    };
    
    associations:BatchResponseLabelsBetweenObjectPair batchResponse = 
        check hubspotClient->/associations/["companies"]/["contacts"]/batch/create.post(batchInput);
    
    io:println("Batch association creation completed!");
    io:println("Status: " + batchResponse.status);
    io:println("Started at: " + batchResponse.startedAt);
    io:println("Completed at: " + batchResponse.completedAt);
    
    // Check for any errors in batch processing
    int:Signed32? numErrorsValue = <int:Signed32?>batchResponse["numErrors"];
    if numErrorsValue is int:Signed32 {
        int:Signed32 errorCount = numErrorsValue;
        if errorCount > 0 {
            io:println("Number of errors: " + errorCount.toString());
            associations:StandardError[]? errorsValue = <associations:StandardError[]?>batchResponse["errors"];
            if errorsValue is associations:StandardError[] {
                foreach associations:StandardError err in errorsValue {
                    io:println("  Error: " + err.message);
                }
            }
        }
    }
    
    // Display successful results
    io:println("\nSuccessfully created associations:");
    foreach associations:LabelsBetweenObjectPair result in batchResponse.results {
        int fromObjId = result.fromObjectId;
        int toObjId = result.toObjectId;
        io:println("  - Company ID: " + fromObjId.toString() + " -> Contact ID: " + toObjId.toString());
        if result.labels.length() > 0 {
            io:println("    Labels: " + result.labels.toString());
        }
    }
    io:println();

    // Final verification: Read all associations again to confirm setup
    io:println("--- Final Verification ---");
    io:println("Verifying all company associations after onboarding setup...");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging finalAssociations = 
        check hubspotClient->/objects/["companies"]/[NEW_COMPANY_ID]/associations/["contacts"].get();
    
    int finalResultsLength = finalAssociations.results.length();
    io:println("Total contacts now associated with company: " + finalResultsLength.toString());
    
    foreach associations:MultiAssociatedObjectWithLabel association in finalAssociations.results {
        int? toObjIdValue = association.toObjectId;
        string toObjIdStr = toObjIdValue is int ? toObjIdValue.toString() : "unknown";
        io:println("\n  Contact ID: " + toObjIdStr);
        foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
            string? assocLabelValue = assocType.label;
            string labelInfo = assocLabelValue is string ? assocLabelValue : "Default";
            io:println("    - Association: " + labelInfo + " (Type ID: " + assocType.typeId.toString() + ")");
        }
    }
    
    io:println("\n=== Customer Onboarding Association Management Complete ===");
    io:println("Summary:");
    io:println("  ✓ Default association created with sales representative");
    io:println("  ✓ Existing associations verified");
    io:println("  ✓ Custom labeled associations created for stakeholders");
    io:println("  ✓ All relationships confirmed");
}