// Customer Onboarding Association Workflow Example
// This example demonstrates how to manage CRM associations when an enterprise deal closes:
// 1. Read existing associations for the deal using batch read
// 2. Create default associations between the deal and company contact
// 3. Create custom labeled association between deal and account manager

import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot authentication
configurable string accessToken = ?;

// Sample IDs representing CRM objects (replace with actual IDs in production)
configurable string dealId = "12345678901";
configurable string companyContactId = "98765432101";
configurable string accountManagerContactId = "11223344556";

// Custom association type ID for "Primary Account Manager" label
// This should be obtained from HubSpot's association type definitions
configurable int:Signed32 primaryAccountManagerTypeId = 279;

public function main() returns error? {
    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("=== Customer Onboarding Association Workflow ===\n");
    
    // Step 1: Read existing associations for the deal to check current relationships
    io:println("Step 1: Reading existing associations for the deal...");
    
    associations:BatchInputPublicFetchAssociationsBatchRequest batchReadPayload = {
        inputs: [
            {
                id: dealId
            }
        ]
    };
    
    // Read associations between deal and contacts
    associations:BatchResponsePublicAssociationMultiWithLabel|error existingAssociations = 
        hubspotClient->/associations/["deals"]/["contacts"]/batch/read.post(batchReadPayload);
    
    if existingAssociations is error {
        io:println("Warning: Could not read existing associations - ", existingAssociations.message());
        io:println("Proceeding with association creation...\n");
    } else {
        io:println("Successfully retrieved existing associations.");
        io:println("Status: ", existingAssociations.status);
        io:println("Number of results: ", existingAssociations.results.length());
        
        // Display existing associations
        foreach associations:PublicAssociationMultiWithLabel result in existingAssociations.results {
            io:println("  Deal ID: ", result.'from.id);
            if result.to.length() > 0 {
                io:println("  Existing associated contacts:");
                foreach associations:MultiAssociatedObjectWithLabel associatedObject in result.to {
                    io:println("    - Contact ID: ", associatedObject.toObjectId);
                    foreach associations:AssociationSpecWithLabel assocType in associatedObject.associationTypes {
                        string? labelValue = <string?>assocType["label"];
                        string labelDisplay = labelValue ?: "No label";
                        io:println("      Type ID: ", assocType.typeId, ", Label: ", labelDisplay, ", Category: ", assocType.category);
                    }
                }
            } else {
                io:println("  No existing contact associations found.");
            }
        }
        io:println();
    }
    
    // Step 2: Create default association between deal and company contact
    io:println("Step 2: Creating default association between deal and company contact...");
    
    associations:BatchResponsePublicDefaultAssociation|error defaultAssociationResult = 
        hubspotClient->/objects/["deals"]/[dealId]/associations/default/["contacts"]/[companyContactId].put();
    
    if defaultAssociationResult is error {
        io:println("Error creating default association: ", defaultAssociationResult.message());
        return defaultAssociationResult;
    }
    
    io:println("Successfully created default association.");
    io:println("Status: ", defaultAssociationResult.status);
    io:println("Number of associations created: ", defaultAssociationResult.results.length());
    
    foreach associations:PublicDefaultAssociation assoc in defaultAssociationResult.results {
        io:println("  From (Deal): ", assoc.'from.id);
        io:println("  To (Contact): ", assoc.to.id);
        associations:AssociationSpec associationSpecValue = assoc.associationSpec;
        int|string? typeIdValue = <int|string?>associationSpecValue["typeId"];
        string? categoryValue = <string?>associationSpecValue["category"];
        io:println("  Association Type ID: ", typeIdValue);
        io:println("  Category: ", categoryValue);
    }
    io:println();
    
    // Step 3: Create custom labeled association between deal and account manager
    // Using "Primary Account Manager" label to distinguish from other team members
    io:println("Step 3: Creating labeled association for Primary Account Manager...");
    
    associations:AssociationSpec[] labeledAssociationPayload = [
        {
            associationCategory: "USER_DEFINED",
            associationTypeId: primaryAccountManagerTypeId
        }
    ];
    
    associations:LabelsBetweenObjectPair|error labeledAssociationResult = 
        hubspotClient->/objects/["deals"]/[dealId]/associations/["contacts"]/[accountManagerContactId].put(labeledAssociationPayload);
    
    if labeledAssociationResult is error {
        io:println("Error creating labeled association: ", labeledAssociationResult.message());
        return labeledAssociationResult;
    }
    
    io:println("Successfully created labeled association for Primary Account Manager.");
    io:println("  From Object Type ID: ", labeledAssociationResult.fromObjectTypeId);
    io:println("  From Object ID (Deal): ", labeledAssociationResult.fromObjectId);
    io:println("  To Object Type ID: ", labeledAssociationResult.toObjectTypeId);
    io:println("  To Object ID (Account Manager): ", labeledAssociationResult.toObjectId);
    io:println("  Labels: ", labeledAssociationResult.labels);
    io:println();
    
    // Summary
    io:println("=== Workflow Complete ===");
    io:println("Customer onboarding associations have been established:");
    io:println("  1. Verified existing deal associations");
    io:println("  2. Created default association: Deal -> Company Contact");
    io:println("  3. Created labeled association: Deal -> Account Manager (Primary Account Manager)");
    io:println("\nThe deal is now properly configured for handoff from sales to customer success.");
}