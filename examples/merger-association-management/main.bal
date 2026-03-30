import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample contact IDs that need to be migrated during the corporate merger
final string[] contactIds = ["101", "102", "103", "104", "105"];

// The acquiring company's ID in HubSpot CRM
final string acquiringCompanyId = "9001";

// Association type IDs for HubSpot (contact to company associations)
// 279 = Primary Company (custom label)
// 280 = Former Employer (custom label)
// 1 = Standard contact to company association
final int:Signed32 primaryCompanyTypeId = 279;
final int:Signed32 formerEmployerTypeId = 280;

public function main() returns error? {
    io:println("=== Corporate Merger CRM Association Management ===\n");

    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };

    associations:Client hubspotClient = check new (config);

    io:println("Step 1: Reading existing associations for contacts...\n");

    // Prepare batch read request to fetch current company associations for all contacts
    associations:PublicFetchAssociationsBatchRequest[] fetchRequests = [];
    foreach string contactId in contactIds {
        fetchRequests.push({
            id: contactId
        });
    }

    associations:BatchInputPublicFetchAssociationsBatchRequest batchReadPayload = {
        inputs: fetchRequests
    };

    // Execute batch read to get existing contact-to-company associations
    associations:BatchResponsePublicAssociationMultiWithLabel readResponse = 
        check hubspotClient->/associations/["contacts"]/["companies"]/batch/read.post(batchReadPayload);

    io:println("Batch read status: ", readResponse.status);
    io:println("Processing completed at: ", readResponse.completedAt);
    io:println("\nExisting associations found:\n");

    // Process and display existing associations
    map<string[]> existingAssociations = {};
    foreach associations:PublicAssociationMultiWithLabel result in readResponse.results {
        string contactId = result.'from.id;
        string[] companyIds = [];

        io:println("Contact ID: ", contactId);
        
        if result.to.length() > 0 {
            foreach associations:MultiAssociatedObjectWithLabel assoc in result.to {
                string objectIdValue = assoc.toObjectId.toString();
                companyIds.push(objectIdValue);
                io:println("  -> Associated with Company ID: ", objectIdValue);
                
                associations:AssociationSpecWithLabel[]? assocTypesValue = assoc?.associationTypes;
                if assocTypesValue is associations:AssociationSpecWithLabel[] {
                    foreach associations:AssociationSpecWithLabel assocType in assocTypesValue {
                        string labelDisplay = assocType?.label ?: "No label";
                        io:println("     Label: ", labelDisplay, " | Category: ", assocType.category);
                    }
                }
            }
        } else {
            io:println("  -> No existing company associations");
        }
        
        existingAssociations[contactId] = companyIds;
        io:println();
    }

    // Check for any errors in the batch read response
    int? numErrorsRead = <int?>readResponse["numErrors"];
    if numErrorsRead is int && numErrorsRead > 0 {
        io:println("Warning: ", numErrorsRead, " errors occurred during batch read");
        associations:StandardError[]? errorsRead = <associations:StandardError[]?>readResponse["errors"];
        if errorsRead is associations:StandardError[] {
            foreach associations:StandardError err in errorsRead {
                io:println("  Error: ", err.message);
            }
        }
    }

    io:println("-------------------------------------------\n");
    io:println("Step 2: Creating new associations to acquiring company...\n");

    // Prepare batch create requests for new associations
    associations:PublicAssociationMultiPost[] createRequests = [];

    foreach string contactId in contactIds {
        // Check if contact already has associations (former employers)
        string[]? existingCompanies = existingAssociations[contactId];
        boolean hasFormerEmployer = existingCompanies is string[] && existingCompanies.length() > 0;

        // Create association specifications based on contact's history
        associations:AssociationSpec[] associationTypes = [];

        // All contacts get linked to the acquiring company as Primary Company
        associationTypes.push({
            associationCategory: "USER_DEFINED",
            associationTypeId: primaryCompanyTypeId
        });

        // If they had previous company associations, also mark with Former Employer label
        if hasFormerEmployer {
            associationTypes.push({
                associationCategory: "USER_DEFINED",
                associationTypeId: formerEmployerTypeId
            });
            io:println("Contact ", contactId, ": Creating 'Primary Company' + 'Former Employer' associations");
        } else {
            io:println("Contact ", contactId, ": Creating 'Primary Company' association only");
        }

        associations:PublicAssociationMultiPost createRequest = {
            'from: {
                id: contactId
            },
            to: {
                id: acquiringCompanyId
            },
            types: associationTypes
        };

        createRequests.push(createRequest);
    }

    associations:BatchInputPublicAssociationMultiPost batchCreatePayload = {
        inputs: createRequests
    };

    // Execute batch create to establish new associations with the acquiring company
    associations:BatchResponseLabelsBetweenObjectPair createResponse = 
        check hubspotClient->/associations/["contacts"]/["companies"]/batch/create.post(batchCreatePayload);

    io:println("\nBatch create status: ", createResponse.status);
    io:println("Processing completed at: ", createResponse.completedAt);
    io:println("\nNew associations created:\n");

    // Display results of the batch create operation
    foreach associations:LabelsBetweenObjectPair result in createResponse.results {
        io:println("Contact ID: ", result.fromObjectId, " -> Company ID: ", result.toObjectId);
        io:println("  Labels applied: ", result.labels);
        io:println("  From Object Type ID: ", result.fromObjectTypeId);
        io:println("  To Object Type ID: ", result.toObjectTypeId);
        io:println();
    }

    // Check for any errors in the batch create response
    int? numErrorsCreate = <int?>createResponse["numErrors"];
    if numErrorsCreate is int && numErrorsCreate > 0 {
        io:println("Warning: ", numErrorsCreate, " errors occurred during batch create");
        associations:StandardError[]? errorsCreate = <associations:StandardError[]?>createResponse["errors"];
        if errorsCreate is associations:StandardError[] {
            foreach associations:StandardError err in errorsCreate {
                io:println("  Error: ", err.message, " | Category: ", err.category);
            }
        }
    }

    io:println("-------------------------------------------\n");
    io:println("Step 3: Verifying new associations...\n");

    // Re-read associations to verify the new links were created successfully
    associations:BatchResponsePublicAssociationMultiWithLabel verifyResponse = 
        check hubspotClient->/associations/["contacts"]/["companies"]/batch/read.post(batchReadPayload);

    io:println("Verification read status: ", verifyResponse.status);
    io:println("\nUpdated associations after merger:\n");

    int totalAssociations = 0;
    foreach associations:PublicAssociationMultiWithLabel result in verifyResponse.results {
        string contactId = result.'from.id;
        io:println("Contact ID: ", contactId);
        
        foreach associations:MultiAssociatedObjectWithLabel assoc in result.to {
            totalAssociations += 1;
            io:println("  -> Company ID: ", assoc.toObjectId.toString());
            
            associations:AssociationSpecWithLabel[]? verifyAssocTypes = assoc?.associationTypes;
            if verifyAssocTypes is associations:AssociationSpecWithLabel[] {
                foreach associations:AssociationSpecWithLabel assocType in verifyAssocTypes {
                    string labelDisplay = assocType?.label ?: "Standard Association";
                    io:println("     Type ID: ", assocType.typeId, " | Label: ", labelDisplay);
                }
            }
        }
        io:println();
    }

    io:println("=== Merger Association Update Complete ===");
    io:println("Total contacts processed: ", contactIds.length());
    io:println("Total associations now tracked: ", totalAssociations);
    io:println("Acquiring company ID: ", acquiringCompanyId);
}