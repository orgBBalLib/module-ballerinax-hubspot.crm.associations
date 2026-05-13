import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample company ID for the new enterprise customer
configurable string newCompanyId = "12345678901";

// Sample contact ID for the primary contact
configurable string primaryContactId = "98765432101";

// Sample deal IDs for related deals
configurable string primaryDealId = "55566677788";
configurable string upsellDealId = "99988877766";

public function main() returns error? {
    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("=== Customer Onboarding Association Management ===\n");
    
    // Step 1: Batch read existing associations to check for duplicates
    io:println("Step 1: Checking existing associations for the company...\n");
    
    // Check existing company-to-contact associations
    associations:BatchInputPublicFetchAssociationsBatchRequest contactCheckPayload = {
        inputs: [
            {
                id: newCompanyId
            }
        ]
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel|error existingContactAssociations = 
        hubspotClient->/associations/["companies"]/["contacts"]/batch/read.post(contactCheckPayload);
    
    if existingContactAssociations is error {
        io:println("Note: No existing contact associations found or error occurred: ", existingContactAssociations.message());
    } else {
        io:println("Existing Contact Associations Status: ", existingContactAssociations.status);
        io:println("Number of results: ", existingContactAssociations.results.length());
        
        foreach associations:PublicAssociationMultiWithLabel result in existingContactAssociations.results {
            io:println("  Company ID: ", result.'from.id);
            io:println("  Associated contacts: ");
            foreach associations:MultiAssociatedObjectWithLabel toObject in result.to {
                io:println("    - Contact ID: ", toObject.toObjectId);
                foreach associations:AssociationSpecWithLabel assocType in toObject.associationTypes {
                    int? typeIdValue = assocType.typeId;
                    string? categoryValue = assocType.category;
                    if typeIdValue is int && categoryValue is string {
                        io:println("      Type ID: ", typeIdValue, ", Category: ", categoryValue);
                    }
                    string? labelValue = assocType?.label;
                    if labelValue is string {
                        io:println("      Label: ", labelValue);
                    }
                }
            }
        }
    }
    
    io:println();
    
    // Check existing company-to-deal associations
    associations:BatchInputPublicFetchAssociationsBatchRequest dealCheckPayload = {
        inputs: [
            {
                id: newCompanyId
            }
        ]
    };
    
    associations:BatchResponsePublicAssociationMultiWithLabel|error existingDealAssociations = 
        hubspotClient->/associations/["companies"]/["deals"]/batch/read.post(dealCheckPayload);
    
    if existingDealAssociations is error {
        io:println("Note: No existing deal associations found or error occurred: ", existingDealAssociations.message());
    } else {
        io:println("Existing Deal Associations Status: ", existingDealAssociations.status);
        io:println("Number of results: ", existingDealAssociations.results.length());
        
        foreach associations:PublicAssociationMultiWithLabel result in existingDealAssociations.results {
            io:println("  Company ID: ", result.'from.id);
            io:println("  Associated deals: ");
            foreach associations:MultiAssociatedObjectWithLabel toObject in result.to {
                io:println("    - Deal ID: ", toObject.toObjectId);
            }
        }
    }
    
    io:println("\n--- Proceeding with association creation ---\n");
    
    // Step 2: Create default association between company and primary contact
    io:println("Step 2: Creating default association between company and primary contact...\n");
    
    associations:BatchResponsePublicDefaultAssociation|error defaultAssociationResult = 
        hubspotClient->/objects/["companies"]/[newCompanyId]/associations/default/["contacts"]/[primaryContactId].put();
    
    if defaultAssociationResult is error {
        io:println("Error creating default association: ", defaultAssociationResult.message());
    } else {
        io:println("Default Association Created Successfully!");
        io:println("Status: ", defaultAssociationResult.status);
        io:println("Completed At: ", defaultAssociationResult.completedAt);
        
        foreach associations:PublicDefaultAssociation assoc in defaultAssociationResult.results {
            io:println("  From Object ID: ", assoc.'from.id);
            io:println("  To Object ID: ", assoc.to.id);
            associations:AssociationSpec assocSpec = assoc.associationSpec;
            int? specTypeId = <int?>assocSpec["typeId"];
            string? specCategory = <string?>assocSpec["category"];
            if specTypeId is int {
                io:println("  Association Type ID: ", specTypeId);
            }
            if specCategory is string {
                io:println("  Association Category: ", specCategory);
            }
        }
    }
    
    io:println();
    
    // Step 3: Create custom labeled associations between company and deals
    io:println("Step 3: Creating custom labeled associations for deals...\n");
    
    // Create 'Primary Deal' labeled association
    io:println("Creating 'Primary Deal' association...");
    
    // Association spec for primary deal - using USER_DEFINED category for custom labels
    // TypeId 341 is commonly used for company-to-deal associations in HubSpot
    associations:AssociationSpec[] primaryDealSpecs = [
        {
            associationCategory: "USER_DEFINED",
            associationTypeId: 341
        }
    ];
    
    associations:LabelsBetweenObjectPair|error primaryDealResult = 
        hubspotClient->/objects/["companies"]/[newCompanyId]/associations/["deals"]/[primaryDealId].put(primaryDealSpecs);
    
    if primaryDealResult is error {
        io:println("Error creating primary deal association: ", primaryDealResult.message());
    } else {
        io:println("Primary Deal Association Created Successfully!");
        io:println("  From Object Type ID: ", primaryDealResult.fromObjectTypeId);
        io:println("  From Object ID: ", primaryDealResult.fromObjectId);
        io:println("  To Object Type ID: ", primaryDealResult.toObjectTypeId);
        io:println("  To Object ID: ", primaryDealResult.toObjectId);
        io:println("  Labels: ", primaryDealResult.labels);
    }
    
    io:println();
    
    // Create 'Upsell Opportunity' labeled association
    io:println("Creating 'Upsell Opportunity' association...");
    
    // Association spec for upsell deal
    associations:AssociationSpec[] upsellDealSpecs = [
        {
            associationCategory: "USER_DEFINED",
            associationTypeId: 341
        }
    ];
    
    associations:LabelsBetweenObjectPair|error upsellDealResult = 
        hubspotClient->/objects/["companies"]/[newCompanyId]/associations/["deals"]/[upsellDealId].put(upsellDealSpecs);
    
    if upsellDealResult is error {
        io:println("Error creating upsell deal association: ", upsellDealResult.message());
    } else {
        io:println("Upsell Deal Association Created Successfully!");
        io:println("  From Object Type ID: ", upsellDealResult.fromObjectTypeId);
        io:println("  From Object ID: ", upsellDealResult.fromObjectId);
        io:println("  To Object Type ID: ", upsellDealResult.toObjectTypeId);
        io:println("  To Object ID: ", upsellDealResult.toObjectId);
        io:println("  Labels: ", upsellDealResult.labels);
    }
    
    io:println("\n=== Customer Onboarding Association Management Complete ===");
    io:println("Summary:");
    io:println("  - Checked existing associations for duplicates");
    io:println("  - Created default association: Company -> Primary Contact");
    io:println("  - Created labeled association: Company -> Primary Deal");
    io:println("  - Created labeled association: Company -> Upsell Opportunity");
}