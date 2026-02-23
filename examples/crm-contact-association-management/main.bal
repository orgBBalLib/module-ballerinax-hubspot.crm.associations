import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample contact and company IDs for demonstration
// In a real scenario, these would come from your CRM data
const string CONTACT_ID = "12345";
const string COMPANY_ID_PRIMARY = "67890";
const string COMPANY_ID_TECHNICAL = "67891";
const string OUTDATED_COMPANY_ID = "67892";

// Association type IDs for contact-to-company relationships
// These are HubSpot-defined type IDs; custom labels use USER_DEFINED category
const int:Signed32 CONTACT_TO_COMPANY_TYPE_ID = 279;

public function main() returns error? {
    io:println("=== CRM Contact-Company Association Management Workflow ===\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    io:println("✓ HubSpot CRM Associations client initialized successfully\n");

    // Step 1: Retrieve all existing associations between the contact and companies
    io:println("--- Step 1: Retrieving Existing Contact-Company Associations ---");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging existingAssociations = 
        check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/["companies"]();
    
    io:println("Found ", existingAssociations.results.length(), " existing association(s):");
    
    foreach associations:MultiAssociatedObjectWithLabel association in existingAssociations.results {
        io:println("  - Company ID: ", association.toObjectId);
        foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
            string? labelValue = assocType?.label;
            string labelInfo = labelValue is string ? labelValue : "No label";
            io:println("    • Type ID: ", assocType.typeId, ", Category: ", assocType.category, ", Label: ", labelInfo);
        }
    }
    
    // Handle pagination if there are more results
    associations:ForwardPaging? pagingValue = existingAssociations?.paging;
    if pagingValue is associations:ForwardPaging {
        associations:NextPage? nextPageValue = pagingValue?.next;
        if nextPageValue is associations:NextPage {
            io:println("  Note: Additional pages of associations available");
        }
    }
    io:println();

    // Step 2: Create new associations with custom labels
    io:println("--- Step 2: Creating New Associations with Custom Labels ---");
    
    // Create association for Primary Decision Maker
    io:println("Creating 'Primary Decision Maker' association...");
    
    associations:AssociationSpec[] primaryDecisionMakerSpecs = [
        {
            associationCategory: "USER_DEFINED",
            associationTypeId: CONTACT_TO_COMPANY_TYPE_ID
        }
    ];
    
    associations:LabelsBetweenObjectPair primaryResult = 
        check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/["companies"]/[COMPANY_ID_PRIMARY].put(primaryDecisionMakerSpecs);
    
    io:println("✓ Association created successfully:");
    io:println("  - From Contact ID: ", primaryResult.fromObjectId);
    io:println("  - To Company ID: ", primaryResult.toObjectId);
    io:println("  - Labels: ", primaryResult.labels);
    io:println();

    // Create association for Technical Contact
    io:println("Creating 'Technical Contact' association...");
    
    associations:AssociationSpec[] technicalContactSpecs = [
        {
            associationCategory: "USER_DEFINED",
            associationTypeId: CONTACT_TO_COMPANY_TYPE_ID
        }
    ];
    
    associations:LabelsBetweenObjectPair technicalResult = 
        check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/["companies"]/[COMPANY_ID_TECHNICAL].put(technicalContactSpecs);
    
    io:println("✓ Association created successfully:");
    io:println("  - From Contact ID: ", technicalResult.fromObjectId);
    io:println("  - To Company ID: ", technicalResult.toObjectId);
    io:println("  - Labels: ", technicalResult.labels);
    io:println();

    // Step 3: Remove outdated or incorrect associations
    io:println("--- Step 3: Removing Outdated Associations ---");
    io:println("Removing association with outdated company (ID: ", OUTDATED_COMPANY_ID, ")...");
    
    check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/["companies"]/[OUTDATED_COMPANY_ID].delete();
    
    io:println("✓ Outdated association removed successfully\n");

    // Step 4: Verify the final state of associations
    io:println("--- Step 4: Verifying Final Association State ---");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging finalAssociations = 
        check hubspotClient->/objects/["contacts"]/[CONTACT_ID]/associations/["companies"]();
    
    io:println("Current associations for Contact ID ", CONTACT_ID, ":");
    
    if finalAssociations.results.length() == 0 {
        io:println("  No associations found.");
    } else {
        foreach associations:MultiAssociatedObjectWithLabel association in finalAssociations.results {
            io:println("  - Company ID: ", association.toObjectId);
            foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
                string? assocLabelValue = assocType?.label;
                string labelDisplay = assocLabelValue is string ? assocLabelValue : "Standard Association";
                io:println("    • Label: ", labelDisplay, " (Category: ", assocType.category, ")");
            }
        }
    }
    
    io:println("\n=== Workflow Completed Successfully ===");
    io:println("Summary:");
    io:println("  • Retrieved existing associations for contact");
    io:println("  • Created new labeled associations (Primary Decision Maker, Technical Contact)");
    io:println("  • Removed outdated association");
    io:println("  • Verified final association state");
}