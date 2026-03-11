import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample IDs representing a newly onboarded enterprise customer scenario
// In production, these would come from your deal closure workflow
const string COMPANY_ID = "12345678901";
const string DECISION_MAKER_CONTACT_ID = "98765432101";
const string TECHNICAL_LEAD_CONTACT_ID = "98765432102";
const string BILLING_CONTACT_ID = "98765432103";
const string ACCOUNT_MANAGER_USER_ID = "11122233344";

// HubSpot object types
const string OBJECT_TYPE_COMPANY = "company";
const string OBJECT_TYPE_CONTACT = "contact";
const string OBJECT_TYPE_USER = "user";

// Association type IDs (HubSpot standard association types)
// Company to Contact: typeId 2 is the standard company-to-contact association
const int:Signed32 COMPANY_TO_CONTACT_TYPE_ID = 2;

public function main() returns error? {
    io:println("=== Customer Onboarding Association Workflow ===\n");
    io:println("Initializing HubSpot CRM Associations client...");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    io:println("Client initialized successfully.\n");

    // Step 1: Read existing associations between the company and contacts
    // This verifies the current data structure before making changes
    io:println("--- Step 1: Reading Existing Company-Contact Associations ---");
    
    associations:BatchInputPublicFetchAssociationsBatchRequest readPayload = {
        inputs: [
            {
                id: COMPANY_ID
            }
        ]
    };

    associations:BatchResponsePublicAssociationMultiWithLabel|error existingAssociations = 
        hubspotClient->/associations/[OBJECT_TYPE_COMPANY]/[OBJECT_TYPE_CONTACT]/batch/read.post(readPayload);

    if existingAssociations is error {
        io:println("Note: No existing associations found or error reading associations.");
        io:println("Proceeding with creating new associations...\n");
    } else {
        io:println("Existing associations retrieved successfully.");
        io:println("Status: ", existingAssociations.status);
        io:println("Number of results: ", existingAssociations.results.length());
        
        foreach associations:PublicAssociationMultiWithLabel result in existingAssociations.results {
            io:println("  Company ID: ", result.'from.id);
            io:println("  Associated contacts: ", result.to.length());
            foreach associations:MultiAssociatedObjectWithLabel toObject in result.to {
                io:println("    - Contact ID: ", toObject.toObjectId);
                foreach associations:AssociationSpecWithLabel assocType in toObject.associationTypes {
                    string? labelValue = assocType?.label;
                    string displayLabel = labelValue ?: "No label";
                    io:println("      Label: ", displayLabel);
                    io:println("      Category: ", assocType.category);
                }
            }
        }
        io:println();
    }

    // Step 2: Create batch associations linking the company to multiple contacts
    // This establishes relationships with decision makers, technical leads, and billing contacts
    io:println("--- Step 2: Creating Batch Associations (Company to Contacts) ---");
    
    associations:AssociationSpec companyToContactSpec = {
        associationCategory: "HUBSPOT_DEFINED",
        associationTypeId: COMPANY_TO_CONTACT_TYPE_ID
    };

    associations:BatchInputPublicAssociationMultiPost batchCreatePayload = {
        inputs: [
            // Association with Decision Maker
            {
                'from: {
                    id: COMPANY_ID
                },
                to: {
                    id: DECISION_MAKER_CONTACT_ID
                },
                types: [companyToContactSpec]
            },
            // Association with Technical Lead
            {
                'from: {
                    id: COMPANY_ID
                },
                to: {
                    id: TECHNICAL_LEAD_CONTACT_ID
                },
                types: [companyToContactSpec]
            },
            // Association with Billing Contact
            {
                'from: {
                    id: COMPANY_ID
                },
                to: {
                    id: BILLING_CONTACT_ID
                },
                types: [companyToContactSpec]
            }
        ]
    };

    associations:BatchResponseLabelsBetweenObjectPair|error batchCreateResult = 
        hubspotClient->/associations/[OBJECT_TYPE_COMPANY]/[OBJECT_TYPE_CONTACT]/batch/create.post(batchCreatePayload);

    if batchCreateResult is error {
        io:println("Error creating batch associations: ", batchCreateResult.message());
        return batchCreateResult;
    }

    io:println("Batch associations created successfully!");
    io:println("Status: ", batchCreateResult.status);
    io:println("Completed at: ", batchCreateResult.completedAt);
    io:println("Number of associations created: ", batchCreateResult.results.length());
    
    foreach associations:LabelsBetweenObjectPair result in batchCreateResult.results {
        io:println("  Association created:");
        io:println("    From (Company): ", result.fromObjectId);
        io:println("    To (Contact): ", result.toObjectId);
        io:println("    Labels: ", result.labels);
    }

    int:Signed32? numErrorsValue = <int:Signed32?>batchCreateResult["numErrors"];
    if numErrorsValue is int:Signed32 && numErrorsValue > 0 {
        io:println("  Warnings: ", numErrorsValue, " errors encountered");
        associations:StandardError[]? errorsValue = <associations:StandardError[]?>batchCreateResult["errors"];
        if errorsValue is associations:StandardError[] {
            foreach associations:StandardError err in errorsValue {
                io:println("    Error: ", err.message);
            }
        }
    }
    io:println();

    // Step 3: Establish default association between the company and the account manager
    // This ensures proper ownership tracking for customer success handoffs
    io:println("--- Step 3: Creating Default Association (Company to Account Manager) ---");
    
    associations:BatchResponsePublicDefaultAssociation|error defaultAssocResult = 
        hubspotClient->/objects/[OBJECT_TYPE_COMPANY]/[COMPANY_ID]/associations/default/[OBJECT_TYPE_USER]/[ACCOUNT_MANAGER_USER_ID].put();

    if defaultAssocResult is error {
        io:println("Error creating default association: ", defaultAssocResult.message());
        return defaultAssocResult;
    }

    io:println("Default association created successfully!");
    io:println("Status: ", defaultAssocResult.status);
    io:println("Completed at: ", defaultAssocResult.completedAt);
    
    foreach associations:PublicDefaultAssociation result in defaultAssocResult.results {
        io:println("  Default association established:");
        io:println("    From (Company): ", result.'from.id);
        io:println("    To (Account Manager): ", result.to.id);
        io:println("    Association Type ID: ", result.associationSpec.associationTypeId);
        io:println("    Association Category: ", result.associationSpec.associationCategory);
    }
    io:println();

    // Summary
    io:println("=== Customer Onboarding Association Workflow Complete ===");
    io:println("Summary:");
    io:println("  - Verified existing company-contact associations");
    io:println("  - Created associations with 3 key contacts (Decision Maker, Technical Lead, Billing)");
    io:println("  - Established account manager ownership for customer success handoff");
    io:println("\nAll stakeholder relationships are now properly documented in HubSpot.");
}