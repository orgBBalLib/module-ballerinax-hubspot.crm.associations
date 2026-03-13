import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample IDs representing a new enterprise client onboarding scenario
// In a real scenario, these would come from your CRM data or onboarding workflow
const string NEW_COMPANY_ID = "12345678901";
const string PRIMARY_CONTACT_ID = "98765432101";

// Deal IDs representing various product lines the client is purchasing
const string DEAL_ID_PRODUCT_LINE_A = "11111111111";
const string DEAL_ID_PRODUCT_LINE_B = "22222222222";
const string DEAL_ID_PRODUCT_LINE_C = "33333333333";

// HubSpot standard association type IDs
// Company to Deal: 341 (Primary), Deal to Company: 342
// Contact to Deal: 3 (Primary), Deal to Contact: 4
const int:Signed32 COMPANY_TO_DEAL_TYPE_ID = 341;
const int:Signed32 CONTACT_TO_DEAL_TYPE_ID = 3;

public function main() returns error? {
    io:println("=== Enterprise Client Onboarding: CRM Relationship Synchronization ===\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    io:println("✓ HubSpot CRM Associations client initialized successfully\n");

    // Step 1: Retrieve all existing associations between the new company and related contacts
    io:println("--- Step 1: Retrieving Existing Company-Contact Associations ---");
    io:println(string `Company ID: ${NEW_COMPANY_ID}`);
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging existingContactAssociations = 
        check hubspotClient->/objects/["companies"]/[NEW_COMPANY_ID]/associations/["contacts"]();
    
    int resultsLength = existingContactAssociations.results.length();
    io:println(string `Found ${resultsLength} existing contact associations:`);
    
    foreach associations:MultiAssociatedObjectWithLabel contactAssoc in existingContactAssociations.results {
        io:println(string `  - Contact ID: ${contactAssoc.toObjectId}`);
        foreach associations:AssociationSpecWithLabel assocType in contactAssoc.associationTypes {
            string? labelValue = assocType?.label;
            string labelDisplay = labelValue ?: "No label";
            io:println(string `    Association Type ID: ${assocType.typeId}, Category: ${assocType.category}, Label: ${labelDisplay}`);
        }
    }
    io:println("");

    // Step 2: Create batch associations linking the company to multiple deal records
    io:println("--- Step 2: Creating Batch Company-Deal Associations ---");
    io:println("Linking company to deal records for various product lines...\n");

    // Prepare the batch input for company-to-deal associations
    associations:PublicAssociationMultiPost[] companyDealAssociations = [
        {
            'from: {id: NEW_COMPANY_ID},
            to: {id: DEAL_ID_PRODUCT_LINE_A},
            types: [
                {
                    associationCategory: "HUBSPOT_DEFINED",
                    associationTypeId: COMPANY_TO_DEAL_TYPE_ID
                }
            ]
        },
        {
            'from: {id: NEW_COMPANY_ID},
            to: {id: DEAL_ID_PRODUCT_LINE_B},
            types: [
                {
                    associationCategory: "HUBSPOT_DEFINED",
                    associationTypeId: COMPANY_TO_DEAL_TYPE_ID
                }
            ]
        },
        {
            'from: {id: NEW_COMPANY_ID},
            to: {id: DEAL_ID_PRODUCT_LINE_C},
            types: [
                {
                    associationCategory: "HUBSPOT_DEFINED",
                    associationTypeId: COMPANY_TO_DEAL_TYPE_ID
                }
            ]
        }
    ];

    associations:BatchInputPublicAssociationMultiPost companyDealBatchInput = {
        inputs: companyDealAssociations
    };

    associations:BatchResponseLabelsBetweenObjectPair companyDealResult = 
        check hubspotClient->/associations/["companies"]/["deals"]/batch/create.post(companyDealBatchInput);

    io:println("Company-Deal Batch Association Result:");
    io:println(string `  Status: ${companyDealResult.status}`);
    int companyDealResultsLength = companyDealResult.results.length();
    io:println(string `  Associations created: ${companyDealResultsLength}`);
    
    foreach associations:LabelsBetweenObjectPair result in companyDealResult.results {
        io:println(string `  - Company ${result.fromObjectId} → Deal ${result.toObjectId}`);
        if result.labels.length() > 0 {
            io:println(string `    Labels: ${result.labels.toString()}`);
        }
    }

    // Check for any errors in the batch operation
    int? numErrorsValue = <int?>companyDealResult["numErrors"];
    if numErrorsValue is int && numErrorsValue > 0 {
        io:println(string `  ⚠ Errors encountered: ${numErrorsValue}`);
        associations:StandardError[]? errors = <associations:StandardError[]?>companyDealResult["errors"];
        if errors is associations:StandardError[] {
            foreach associations:StandardError err in errors {
                io:println(string `    Error: ${err.message}`);
            }
        }
    }
    io:println("");

    // Step 3: Establish default associations between primary contact and each deal
    io:println("--- Step 3: Creating Default Contact-Deal Associations ---");
    io:println("Establishing ownership tracking between primary contact and deals...\n");

    // Prepare batch input for default contact-to-deal associations
    associations:PublicDefaultAssociationMultiPost[] contactDealAssociations = [
        {
            'from: {id: PRIMARY_CONTACT_ID},
            to: {id: DEAL_ID_PRODUCT_LINE_A}
        },
        {
            'from: {id: PRIMARY_CONTACT_ID},
            to: {id: DEAL_ID_PRODUCT_LINE_B}
        },
        {
            'from: {id: PRIMARY_CONTACT_ID},
            to: {id: DEAL_ID_PRODUCT_LINE_C}
        }
    ];

    associations:BatchInputPublicDefaultAssociationMultiPost contactDealBatchInput = {
        inputs: contactDealAssociations
    };

    associations:BatchResponsePublicDefaultAssociation contactDealResult = 
        check hubspotClient->/associations/["contacts"]/["deals"]/batch/associate/'default.post(contactDealBatchInput);

    io:println("Contact-Deal Default Association Result:");
    io:println(string `  Status: ${contactDealResult.status}`);
    int contactDealResultsLength = contactDealResult.results.length();
    io:println(string `  Default associations created: ${contactDealResultsLength}`);

    foreach associations:PublicDefaultAssociation result in contactDealResult.results {
        io:println(string `  - Contact ${result.'from.id} → Deal ${result.to.id}`);
        io:println(string `    Association Type ID: ${result.associationSpec.associationTypeId}, Category: ${result.associationSpec.associationCategory}`);
    }

    // Check for any errors in the default association batch operation
    int? contactNumErrorsValue = <int?>contactDealResult["numErrors"];
    if contactNumErrorsValue is int && contactNumErrorsValue > 0 {
        io:println(string `  ⚠ Errors encountered: ${contactNumErrorsValue}`);
        associations:StandardError[]? contactErrors = <associations:StandardError[]?>contactDealResult["errors"];
        if contactErrors is associations:StandardError[] {
            foreach associations:StandardError err in contactErrors {
                io:println(string `    Error: ${err.message}`);
            }
        }
    }
    io:println("");

    // Summary
    io:println("=== Enterprise Client Onboarding Complete ===");
    io:println("Summary:");
    io:println(string `  • Retrieved existing contact associations for company ${NEW_COMPANY_ID}`);
    io:println(string `  • Created ${companyDealResultsLength} company-deal associations`);
    io:println(string `  • Established ${contactDealResultsLength} default contact-deal associations`);
    io:println("\nThe CRM relationships are now synchronized for the new enterprise client.");
}