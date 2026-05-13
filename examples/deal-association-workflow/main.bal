import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot authentication
configurable string accessToken = ?;

// Sample IDs representing a newly created deal, company, and primary contact
// In a real scenario, these would come from HubSpot CRM events or API responses
const string NEW_DEAL_ID = "12345678901";
const string COMPANY_ID = "98765432101";
const string PRIMARY_CONTACT_ID = "55566677788";

// Custom association type ID for "Decision Maker" label
// This would be obtained from HubSpot's association type definitions
const int:Signed32 DECISION_MAKER_ASSOCIATION_TYPE_ID = 279;

public function main() returns error? {
    io:println("=== Sales Pipeline Management: Deal Association Workflow ===\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    io:println("Successfully initialized HubSpot CRM Associations client.\n");

    // Step 1: Read existing associations for the company to identify linked contacts
    io:println("Step 1: Reading existing associations for company to identify linked contacts...");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging companyContacts = 
        check hubspotClient->/objects/["companies"]/[COMPANY_ID]/associations/["contacts"]();
    
    io:println("Found ", companyContacts.results.length(), " contact(s) associated with the company.");
    
    // Display the associated contacts and their association types
    foreach associations:MultiAssociatedObjectWithLabel contact in companyContacts.results {
        io:println("  - Contact ID: ", contact.toObjectId);
        foreach associations:AssociationSpecWithLabel assocType in contact.associationTypes {
            string? labelValue = assocType?.label;
            string labelInfo = labelValue ?: "No label";
            io:println("    Association Type ID: ", assocType.typeId, 
                      ", Category: ", assocType.category, 
                      ", Label: ", labelInfo);
        }
    }
    io:println();

    // Step 2: Create a default association between the new deal and the company
    io:println("Step 2: Creating default association between deal and company...");
    
    associations:BatchResponsePublicDefaultAssociation dealCompanyAssociation = 
        check hubspotClient->/objects/["deals"]/[NEW_DEAL_ID]/associations/default/["companies"]/[COMPANY_ID].put();
    
    io:println("Default association created successfully!");
    io:println("  Status: ", dealCompanyAssociation.status);
    io:println("  Completed At: ", dealCompanyAssociation.completedAt);
    
    // Display the created association details
    foreach associations:PublicDefaultAssociation result in dealCompanyAssociation.results {
        io:println("  From Object ID: ", result.'from.id);
        io:println("  To Object ID: ", result.to.id);
        associations:AssociationSpec associationSpecValue = result.associationSpec;
        int|string? typeIdValue = <int|string?>associationSpecValue["typeId"];
        string? categoryValue = <string?>associationSpecValue["category"];
        io:println("  Association Type ID: ", typeIdValue);
        io:println("  Association Category: ", categoryValue);
    }
    io:println();

    // Step 3: Create a custom labeled association between the deal and primary contact
    // Using 'Decision Maker' label for better pipeline tracking and reporting
    io:println("Step 3: Creating custom labeled association between deal and primary contact...");
    io:println("        Label: 'Decision Maker' for enhanced pipeline tracking");
    
    // Define the association specification with the Decision Maker label
    associations:AssociationSpec[] associationSpecs = [
        {
            associationTypeId: DECISION_MAKER_ASSOCIATION_TYPE_ID,
            associationCategory: "USER_DEFINED"
        }
    ];
    
    associations:LabelsBetweenObjectPair dealContactAssociation = 
        check hubspotClient->/objects/["deals"]/[NEW_DEAL_ID]/associations/["contacts"]/[PRIMARY_CONTACT_ID].put(associationSpecs);
    
    io:println("Custom labeled association created successfully!");
    io:println("  From Object ID: ", dealContactAssociation.fromObjectId);
    io:println("  From Object Type ID: ", dealContactAssociation.fromObjectTypeId);
    io:println("  To Object ID: ", dealContactAssociation.toObjectId);
    io:println("  To Object Type ID: ", dealContactAssociation.toObjectTypeId);
    io:println("  Labels: ", dealContactAssociation.labels);
    io:println();

    // Summary of the workflow
    io:println("=== Workflow Summary ===");
    io:println("1. Retrieved existing company-contact associations for context");
    io:println("2. Created default deal-to-company association");
    io:println("3. Created labeled deal-to-contact association with 'Decision Maker' label");
    io:println("\nSales pipeline management workflow completed successfully!");
    io:println("The new deal is now properly associated for tracking and reporting.");
}