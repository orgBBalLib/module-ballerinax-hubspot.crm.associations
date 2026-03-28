import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot authentication
configurable string accessToken = ?;

// Sample IDs representing newly created records during customer onboarding
// In a real scenario, these would come from creating the actual records
const string NEW_COMPANY_ID = "12345678901";
const string PRIMARY_CONTACT_ID = "23456789012";
const string INITIAL_DEAL_ID = "34567890123";

// HubSpot object types
const string OBJECT_TYPE_COMPANY = "companies";
const string OBJECT_TYPE_CONTACT = "contacts";
const string OBJECT_TYPE_DEAL = "deals";

public function main() returns error? {
    io:println("=== Customer Onboarding Association Management ===\n");
    
    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("HubSpot CRM Associations client initialized successfully.\n");
    
    // Step 1: Create association between the new company and primary contact using default association types
    io:println("Step 1: Creating association between Company and Primary Contact...");
    io:println("  Company ID: " + NEW_COMPANY_ID);
    io:println("  Contact ID: " + PRIMARY_CONTACT_ID);
    
    associations:BatchResponsePublicDefaultAssociation companyToContactAssociation = 
        check hubspotClient->/objects/[OBJECT_TYPE_COMPANY]/[NEW_COMPANY_ID]/associations/default/[OBJECT_TYPE_CONTACT]/[PRIMARY_CONTACT_ID].put();
    
    io:println("  Association created successfully!");
    io:println("  Status: " + companyToContactAssociation.status);
    int companyToContactResultCount = companyToContactAssociation.results.length();
    io:println("  Results count: " + companyToContactResultCount.toString());
    
    // Display the created association details
    foreach associations:PublicDefaultAssociation result in companyToContactAssociation.results {
        io:println("    - From Object ID: " + result.'from.id);
        io:println("    - To Object ID: " + result.to.id);
        int? typeIdValue = <int?>result.associationSpec["typeId"];
        string? categoryValue = <string?>result.associationSpec["category"];
        if typeIdValue is int {
            io:println("    - Association Type ID: " + typeIdValue.toString());
        }
        if categoryValue is string {
            io:println("    - Association Category: " + categoryValue);
        }
    }
    io:println();
    
    // Step 2: Create association between the primary contact and the initial deal
    io:println("Step 2: Creating association between Primary Contact and Initial Deal...");
    io:println("  Contact ID: " + PRIMARY_CONTACT_ID);
    io:println("  Deal ID: " + INITIAL_DEAL_ID);
    
    associations:BatchResponsePublicDefaultAssociation contactToDealAssociation = 
        check hubspotClient->/objects/[OBJECT_TYPE_CONTACT]/[PRIMARY_CONTACT_ID]/associations/default/[OBJECT_TYPE_DEAL]/[INITIAL_DEAL_ID].put();
    
    io:println("  Association created successfully!");
    io:println("  Status: " + contactToDealAssociation.status);
    int contactToDealResultCount = contactToDealAssociation.results.length();
    io:println("  Results count: " + contactToDealResultCount.toString());
    
    // Display the created association details
    foreach associations:PublicDefaultAssociation result in contactToDealAssociation.results {
        io:println("    - From Object ID: " + result.'from.id);
        io:println("    - To Object ID: " + result.to.id);
        int? typeIdValue = <int?>result.associationSpec["typeId"];
        string? categoryValue = <string?>result.associationSpec["category"];
        if typeIdValue is int {
            io:println("    - Association Type ID: " + typeIdValue.toString());
        }
        if categoryValue is string {
            io:println("    - Association Category: " + categoryValue);
        }
    }
    io:println();
    
    // Step 3: Also create a direct association between the company and the deal
    io:println("Step 3: Creating direct association between Company and Initial Deal...");
    io:println("  Company ID: " + NEW_COMPANY_ID);
    io:println("  Deal ID: " + INITIAL_DEAL_ID);
    
    associations:BatchResponsePublicDefaultAssociation companyToDealAssociation = 
        check hubspotClient->/objects/[OBJECT_TYPE_COMPANY]/[NEW_COMPANY_ID]/associations/default/[OBJECT_TYPE_DEAL]/[INITIAL_DEAL_ID].put();
    
    io:println("  Association created successfully!");
    io:println("  Status: " + companyToDealAssociation.status);
    int companyToDealResultCount = companyToDealAssociation.results.length();
    io:println("  Results count: " + companyToDealResultCount.toString());
    
    foreach associations:PublicDefaultAssociation result in companyToDealAssociation.results {
        io:println("    - From Object ID: " + result.'from.id);
        io:println("    - To Object ID: " + result.to.id);
        int? typeIdValue = <int?>result.associationSpec["typeId"];
        string? categoryValue = <string?>result.associationSpec["category"];
        if typeIdValue is int {
            io:println("    - Association Type ID: " + typeIdValue.toString());
        }
        if categoryValue is string {
            io:println("    - Association Category: " + categoryValue);
        }
    }
    io:println();
    
    // Step 4: Verify all associations by reading back the company's associations
    io:println("Step 4: Verifying the complete relationship graph for the company...\n");
    
    // Verify company to contact associations
    io:println("  4a. Retrieving Company -> Contact associations...");
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging companyContactAssociations = 
        check hubspotClient->/objects/[OBJECT_TYPE_COMPANY]/[NEW_COMPANY_ID]/associations/[OBJECT_TYPE_CONTACT].get();
    
    int companyContactCount = companyContactAssociations.results.length();
    io:println("    Found " + companyContactCount.toString() + " contact association(s):");
    foreach associations:MultiAssociatedObjectWithLabel assoc in companyContactAssociations.results {
        io:println("      - Associated Contact ID: " + assoc.toObjectId.toString());
        associations:AssociationSpecWithLabel[]? associationTypesValue = assoc.associationTypes;
        if associationTypesValue is associations:AssociationSpecWithLabel[] {
            foreach associations:AssociationSpecWithLabel assocType in associationTypesValue {
                io:println("        Type ID: " + assocType.typeId.toString() + ", Category: " + assocType.category);
                string? labelValue = assocType?.label;
                if labelValue is string {
                    io:println("        Label: " + labelValue);
                }
            }
        }
    }
    io:println();
    
    // Verify company to deal associations
    io:println("  4b. Retrieving Company -> Deal associations...");
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging companyDealAssociations = 
        check hubspotClient->/objects/[OBJECT_TYPE_COMPANY]/[NEW_COMPANY_ID]/associations/[OBJECT_TYPE_DEAL].get();
    
    int companyDealCount = companyDealAssociations.results.length();
    io:println("    Found " + companyDealCount.toString() + " deal association(s):");
    foreach associations:MultiAssociatedObjectWithLabel assoc in companyDealAssociations.results {
        io:println("      - Associated Deal ID: " + assoc.toObjectId.toString());
        associations:AssociationSpecWithLabel[]? associationTypesValue = assoc.associationTypes;
        if associationTypesValue is associations:AssociationSpecWithLabel[] {
            foreach associations:AssociationSpecWithLabel assocType in associationTypesValue {
                io:println("        Type ID: " + assocType.typeId.toString() + ", Category: " + assocType.category);
                string? labelValue = assocType?.label;
                if labelValue is string {
                    io:println("        Label: " + labelValue);
                }
            }
        }
    }
    io:println();
    
    // Verify contact to deal associations
    io:println("  4c. Retrieving Contact -> Deal associations...");
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging contactDealAssociations = 
        check hubspotClient->/objects/[OBJECT_TYPE_CONTACT]/[PRIMARY_CONTACT_ID]/associations/[OBJECT_TYPE_DEAL].get();
    
    int contactDealCount = contactDealAssociations.results.length();
    io:println("    Found " + contactDealCount.toString() + " deal association(s):");
    foreach associations:MultiAssociatedObjectWithLabel assoc in contactDealAssociations.results {
        io:println("      - Associated Deal ID: " + assoc.toObjectId.toString());
        associations:AssociationSpecWithLabel[]? associationTypesValue = assoc.associationTypes;
        if associationTypesValue is associations:AssociationSpecWithLabel[] {
            foreach associations:AssociationSpecWithLabel assocType in associationTypesValue {
                io:println("        Type ID: " + assocType.typeId.toString() + ", Category: " + assocType.category);
                string? labelValue = assocType?.label;
                if labelValue is string {
                    io:println("        Label: " + labelValue);
                }
            }
        }
    }
    io:println();
    
    // Summary
    io:println("=== Customer Onboarding Association Summary ===");
    io:println("Company ID: " + NEW_COMPANY_ID);
    io:println("  └── Associated Contacts: " + companyContactCount.toString());
    io:println("  └── Associated Deals: " + companyDealCount.toString());
    io:println("Primary Contact ID: " + PRIMARY_CONTACT_ID);
    io:println("  └── Associated Deals: " + contactDealCount.toString());
    io:println("\nCustomer onboarding association management completed successfully!");
    io:println("All relationships have been established for the new enterprise customer.");
}