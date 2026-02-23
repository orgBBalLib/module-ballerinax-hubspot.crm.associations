import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample CRM object IDs for demonstration
// In a real scenario, these would be actual HubSpot CRM record IDs
const string CONTACT_ID = "12345";
const string NEW_COMPANY_ID = "67890";
const string OUTDATED_COMPANY_ID = "11111";

public function main() returns error? {
    io:println("=== CRM Contact-Company Relationship Management Workflow ===\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("Successfully initialized HubSpot CRM Associations client.\n");

    // Step 1: Retrieve all existing associations between the contact and companies
    io:println("--- Step 1: Auditing Current Contact-Company Relationships ---");
    io:println(string `Retrieving associations for Contact ID: ${CONTACT_ID}`);
    io:println("");

    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging existingAssociations = 
        check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/["companies"]();

    io:println("Current associations found:");
    
    int resultsLength = existingAssociations.results.length();
    if resultsLength == 0 {
        io:println("  No existing company associations found for this contact.");
    } else {
        foreach associations:MultiAssociatedObjectWithLabel association in existingAssociations.results {
            io:println(string `  - Company ID: ${association.toObjectId}`);
            foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
                string labelInfo = assocType?.label ?: "No label";
                int typeIdValue = assocType.typeId;
                string categoryValue = assocType.category;
                io:println(string `    Type ID: ${typeIdValue}`);
                io:println(string `    Label: ${labelInfo}`);
                io:println(string `    Category: ${categoryValue}`);
            }
        }
    }

    // Check for pagination information
    associations:ForwardPaging? pagingValue = existingAssociations.paging;
    if pagingValue is associations:ForwardPaging {
        associations:NextPage? nextPageValue = pagingValue.next;
        if nextPageValue is associations:NextPage {
            io:println("\n  Note: Additional associations exist. Use pagination to retrieve more.");
        }
    }

    io:println("\nAudit complete.\n");

    // Step 2: Create a new default association with a newly onboarded company
    io:println("--- Step 2: Creating New Association with Onboarded Company ---");
    io:println(string `Creating default association between Contact ID: ${CONTACT_ID} and new Company ID: ${NEW_COMPANY_ID}`);
    io:println("");

    associations:BatchResponsePublicDefaultAssociation createResponse = 
        check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/default/["companies"]/[NEW_COMPANY_ID].put();

    io:println("Association creation response:");
    io:println(string `  Status: ${createResponse.status}`);
    io:println(string `  Started At: ${createResponse.startedAt}`);
    io:println(string `  Completed At: ${createResponse.completedAt}`);

    int createResultsLength = createResponse.results.length();
    if createResultsLength > 0 {
        io:println("  Created associations:");
        foreach associations:PublicDefaultAssociation result in createResponse.results {
            string fromObjectId = result.'from.id;
            string toObjectId = result.to.id;
            associations:AssociationSpec assocSpec = result.associationSpec;
            int? typeIdVal = <int?>assocSpec["typeId"];
            string? categoryVal = <string?>assocSpec["category"];
            string typeIdStr = typeIdVal is int ? typeIdVal.toString() : "";
            string categoryStr = categoryVal ?: "";
            io:println(string `    - From Object ID: ${fromObjectId}`);
            io:println(string `      To Object ID: ${toObjectId}`);
            io:println(string `      Association Type ID: ${typeIdStr}`);
            io:println(string `      Association Category: ${categoryStr}`);
        }
    }

    // Check for any errors during creation
    int:Signed32? numErrorsValue = createResponse.numErrors;
    if numErrorsValue is int:Signed32 && numErrorsValue > 0 {
        io:println(string `  Warning: ${numErrorsValue} error(s) occurred during association creation.`);
        associations:StandardError[]? errorsValue = createResponse.errors;
        if errorsValue is associations:StandardError[] {
            foreach associations:StandardError err in errorsValue {
                io:println(string `    Error: ${err.message}`);
                io:println(string `    Category: ${err.category}`);
            }
        }
    }

    io:println("\nNew association created successfully.\n");

    // Step 3: Remove an outdated association with a company no longer in business relationship
    io:println("--- Step 3: Removing Outdated Company Association ---");
    io:println(string `Removing association between Contact ID: ${CONTACT_ID} and outdated Company ID: ${OUTDATED_COMPANY_ID}`);
    io:println("");

    check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/["companies"]/[OUTDATED_COMPANY_ID].delete();

    io:println("Outdated association removed successfully.");
    io:println("CRM data is now clean and accurate for sales reporting.\n");

    // Summary
    io:println("=== Workflow Summary ===");
    io:println(string `1. Audited existing contact-company associations for Contact ID: ${CONTACT_ID}`);
    io:println(string `2. Created new default association with Company ID: ${NEW_COMPANY_ID}`);
    io:println(string `3. Removed outdated association with Company ID: ${OUTDATED_COMPANY_ID}`);
    io:println("\nCRM contact-company relationship management workflow completed successfully!");
}