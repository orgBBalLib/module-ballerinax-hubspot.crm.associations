import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Business rule mapping: contact IDs to their new company associations with labels
type ContactCompanyMapping record {
    string contactId;
    string newCompanyId;
    string relationshipLabel;
};

public function main() returns error? {
    // Initialize the HubSpot CRM Associations client
    associations:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (config);
    
    io:println("=== HubSpot CRM Association Sync Workflow ===\n");
    
    // Step 1: Define the batch of contacts to check for existing associations
    // These are sample contact IDs that we want to analyze
    string[] contactIds = ["101", "102", "103", "104"];
    
    io:println("Step 1: Preparing to read existing contact-to-company associations...");
    io:println("Contact IDs to analyze: ", contactIds);
    
    // Build the batch request to fetch existing associations
    associations:PublicFetchAssociationsBatchRequest[] fetchInputs = [];
    foreach string contactId in contactIds {
        associations:PublicFetchAssociationsBatchRequest fetchRequest = {
            id: contactId
        };
        fetchInputs.push(fetchRequest);
    }
    
    associations:BatchInputPublicFetchAssociationsBatchRequest batchReadRequest = {
        inputs: fetchInputs
    };
    
    // Step 2: Read existing contact-to-company associations in batch
    io:println("\nStep 2: Reading existing contact-to-company associations...");
    
    associations:BatchResponsePublicAssociationMultiWithLabel readResponse = 
        check hubspotClient->/associations/["contacts"]/["companies"]/batch/read.post(batchReadRequest);
    
    io:println("Batch read status: ", readResponse.status);
    io:println("Completed at: ", readResponse.completedAt);
    
    // Step 3: Analyze existing associations and display current relationships
    io:println("\nStep 3: Analyzing current associations...");
    
    // Track contacts that already have associations
    map<string[]> existingAssociations = {};
    
    foreach associations:PublicAssociationMultiWithLabel result in readResponse.results {
        associations:PublicObjectId fromObject = result.'from;
        string fromId = fromObject.id;
        string[] associatedCompanies = [];
        
        foreach associations:MultiAssociatedObjectWithLabel toObj in result.to {
            string toObjectId = toObj.toObjectId.toString();
            associatedCompanies.push(toObjectId);
            
            // Display association details including labels
            io:println("  Contact ", fromId, " -> Company ", toObjectId);
            foreach associations:AssociationSpecWithLabel assocType in toObj.associationTypes {
                string? labelValue = assocType?.label;
                string labelInfo = labelValue ?: "No label";
                io:println("    - Type ID: ", assocType.typeId, ", Label: ", labelInfo, ", Category: ", assocType.category);
            }
        }
        
        existingAssociations[fromId] = associatedCompanies;
    }
    
    // Check for any errors in the read response
    int? readNumErrors = <int?>readResponse["numErrors"];
    if readNumErrors is int && readNumErrors > 0 {
        io:println("\nWarning: ", readNumErrors, " errors occurred during batch read");
        associations:StandardError[]? readErrors = <associations:StandardError[]?>readResponse["errors"];
        if readErrors is associations:StandardError[] {
            foreach associations:StandardError err in readErrors {
                io:println("  Error: ", err.message);
            }
        }
    }
    
    // Step 4: Define business rules for new associations
    // These represent updated business relationships that need to be created
    io:println("\nStep 4: Applying business rules for new associations...");
    
    ContactCompanyMapping[] newRelationships = [
        {contactId: "101", newCompanyId: "501", relationshipLabel: "Primary Vendor"},
        {contactId: "102", newCompanyId: "502", relationshipLabel: "Partner"},
        {contactId: "103", newCompanyId: "503", relationshipLabel: "Primary Vendor"},
        {contactId: "104", newCompanyId: "504", relationshipLabel: "Partner"}
    ];
    
    // Filter out relationships that might already exist
    ContactCompanyMapping[] relationshipsToCreate = [];
    foreach ContactCompanyMapping mapping in newRelationships {
        string[]? existingCompanies = existingAssociations[mapping.contactId];
        if existingCompanies is string[] {
            boolean alreadyExists = false;
            foreach string companyId in existingCompanies {
                if companyId == mapping.newCompanyId {
                    alreadyExists = true;
                    io:println("  Skipping: Contact ", mapping.contactId, " already associated with Company ", mapping.newCompanyId);
                    break;
                }
            }
            if !alreadyExists {
                relationshipsToCreate.push(mapping);
            }
        } else {
            relationshipsToCreate.push(mapping);
        }
    }
    
    io:println("  Relationships to create: ", relationshipsToCreate.length());
    
    // Step 5: Create new labeled associations in batch
    if relationshipsToCreate.length() > 0 {
        io:println("\nStep 5: Creating new labeled associations...");
        
        associations:PublicAssociationMultiPost[] createInputs = [];
        
        foreach ContactCompanyMapping mapping in relationshipsToCreate {
            // Define the association specification with a custom label
            // Using typeId 1 for contact-to-company primary association
            // Using USER_DEFINED category for custom labeled associations
            associations:AssociationSpec[] associationTypes = [
                {
                    associationCategory: "USER_DEFINED",
                    associationTypeId: 1
                }
            ];
            
            associations:PublicAssociationMultiPost createRequest = {
                'from: {
                    id: mapping.contactId
                },
                to: {
                    id: mapping.newCompanyId
                },
                types: associationTypes
            };
            
            createInputs.push(createRequest);
            io:println("  Preparing: Contact ", mapping.contactId, " -> Company ", mapping.newCompanyId, 
                       " (", mapping.relationshipLabel, ")");
        }
        
        associations:BatchInputPublicAssociationMultiPost batchCreateRequest = {
            inputs: createInputs
        };
        
        // Execute the batch create operation
        associations:BatchResponseLabelsBetweenObjectPair createResponse = 
            check hubspotClient->/associations/["contacts"]/["companies"]/batch/create.post(batchCreateRequest);
        
        io:println("\nBatch create status: ", createResponse.status);
        io:println("Completed at: ", createResponse.completedAt);
        
        // Display created associations
        io:println("\nCreated associations:");
        foreach associations:LabelsBetweenObjectPair result in createResponse.results {
            io:println("  Contact ", result.fromObjectId, " -> Company ", result.toObjectId);
            io:println("    Labels: ", result.labels);
            io:println("    From Object Type ID: ", result.fromObjectTypeId);
            io:println("    To Object Type ID: ", result.toObjectTypeId);
        }
        
        // Check for any errors in the create response
        int? createNumErrors = <int?>createResponse["numErrors"];
        if createNumErrors is int && createNumErrors > 0 {
            io:println("\nWarning: ", createNumErrors, " errors occurred during batch create");
            associations:StandardError[]? createErrors = <associations:StandardError[]?>createResponse["errors"];
            if createErrors is associations:StandardError[] {
                foreach associations:StandardError err in createErrors {
                    io:println("  Error: ", err.message, " (Category: ", err.category, ")");
                }
            }
        }
        
        io:println("\n=== Association Sync Complete ===");
        io:println("Total associations created: ", createResponse.results.length());
    } else {
        io:println("\nNo new associations needed - all relationships already exist.");
        io:println("\n=== Association Sync Complete ===");
    }
}