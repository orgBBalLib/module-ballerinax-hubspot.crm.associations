// Customer Onboarding Association Workflow Example
// This example demonstrates how to associate company, contact, and deal records
// during customer onboarding using the HubSpot CRM Associations API

import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample IDs representing CRM records (in a real scenario, these would come from your CRM)
configurable string companyId = "12345678901";
configurable string primaryContactId = "98765432101";
configurable string dealId = "11223344556";

// Custom association type ID for "Primary Deal" (this would be defined in your HubSpot account)
// In HubSpot, custom association type IDs are typically created through the API or UI
const int:Signed32 PRIMARY_DEAL_ASSOCIATION_TYPE_ID = 279;

public function main() returns error? {
    io:println("=== Customer Onboarding Association Workflow ===\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig connectionConfig = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (connectionConfig);
    io:println("✓ HubSpot CRM Associations client initialized successfully\n");

    // Step 1: Create default association between company and primary contact
    io:println("Step 1: Creating default association between Company and Primary Contact...");
    
    associations:BatchInputPublicDefaultAssociationMultiPost batchAssociationPayload = {
        inputs: [
            {
                'from: {
                    id: companyId
                },
                to: {
                    id: primaryContactId
                }
            }
        ]
    };

    associations:BatchResponsePublicDefaultAssociation batchResponse = check hubspotClient->/associations/["companies"]/["contacts"]/batch/associate/default.post(batchAssociationPayload);
    
    io:println("   Status: ", batchResponse.status);
    io:println("   Completed At: ", batchResponse.completedAt);
    io:println("   Results Count: ", batchResponse.results.length());
    
    foreach associations:PublicDefaultAssociation result in batchResponse.results {
        io:println("   - Associated Company (", result.'from.id, ") with Contact (", result.to.id, ")");
        associations:AssociationSpec associationSpec = result.associationSpec;
        int? typeIdValue = <int?>associationSpec["typeId"];
        string? categoryValue = <string?>associationSpec["category"];
        io:println("     Association Type ID: ", typeIdValue);
        io:println("     Category: ", categoryValue);
    }
    
    int:Signed32? numErrorsValue = batchResponse.numErrors;
    if numErrorsValue is int:Signed32 && numErrorsValue > 0 {
        io:println("   ⚠ Errors encountered: ", numErrorsValue);
        associations:StandardError[]? errorsValue = batchResponse.errors;
        if errorsValue is associations:StandardError[] {
            foreach associations:StandardError err in errorsValue {
                io:println("     Error: ", err.message);
            }
        }
    }
    io:println("✓ Default association created successfully\n");

    // Step 2: Retrieve all existing associations for the company to verify the contact link
    io:println("Step 2: Retrieving all associations for the Company to verify Contact link...");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging companyAssociations = check hubspotClient->/objects/["companies"]/[companyId]/associations/["contacts"].get();
    
    io:println("   Found ", companyAssociations.results.length(), " associated contact(s):");
    
    boolean contactLinkVerified = false;
    foreach associations:MultiAssociatedObjectWithLabel association in companyAssociations.results {
        io:println("   - Contact ID: ", association.toObjectId);
        
        string toObjectIdStr = association.toObjectId.toString();
        if toObjectIdStr == primaryContactId {
            contactLinkVerified = true;
            io:println("     ✓ Primary contact link verified!");
        }
        
        io:println("     Association Types:");
        foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
            io:println("       - Type ID: ", assocType.typeId);
            io:println("         Category: ", assocType.category);
            string? labelValue = assocType.label;
            if labelValue is string {
                io:println("         Label: ", labelValue);
            }
        }
    }
    
    // Check for pagination if there are more results
    associations:ForwardPaging? pagingValue = companyAssociations.paging;
    if pagingValue is associations:ForwardPaging {
        associations:NextPage? nextPageValue = <associations:NextPage?>pagingValue["next"];
        if nextPageValue is associations:NextPage {
            io:println("   Note: Additional associations available (pagination cursor: ", nextPageValue.after, ")");
        }
    }
    
    if contactLinkVerified {
        io:println("✓ Contact association verification completed successfully\n");
    } else {
        io:println("⚠ Primary contact link not found in associations\n");
    }

    // Step 3: Create a custom labeled association between company and deal
    io:println("Step 3: Creating custom labeled association between Company and Deal (Primary Deal)...");
    
    associations:AssociationSpec[] dealAssociationSpecs = [
        {
            associationCategory: "USER_DEFINED",
            associationTypeId: PRIMARY_DEAL_ASSOCIATION_TYPE_ID
        }
    ];
    
    associations:LabelsBetweenObjectPair labeledAssociationResult = check hubspotClient->/objects/["companies"]/[companyId]/associations/["deals"]/[dealId].put(dealAssociationSpecs);
    
    io:println("   Association Created Successfully:");
    io:println("   - From Object ID: ", labeledAssociationResult.fromObjectId);
    io:println("   - From Object Type ID: ", labeledAssociationResult.fromObjectTypeId);
    io:println("   - To Object ID: ", labeledAssociationResult.toObjectId);
    io:println("   - To Object Type ID: ", labeledAssociationResult.toObjectTypeId);
    io:println("   - Labels: ", labeledAssociationResult.labels);
    io:println("✓ Custom labeled association (Primary Deal) created successfully\n");

    // Final Summary
    io:println("=== Customer Onboarding Association Workflow Complete ===");
    io:println("Summary:");
    io:println("  • Company ID: ", companyId);
    io:println("  • Primary Contact ID: ", primaryContactId);
    io:println("  • Deal ID: ", dealId);
    io:println("  • All CRM relationships established for customer onboarding");
    io:println("\nSales teams now have complete visibility into this account hierarchy.");
}