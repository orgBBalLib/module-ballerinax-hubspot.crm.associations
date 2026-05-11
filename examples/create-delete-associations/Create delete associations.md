# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) by creating default associations, creating associations with labels, reading associations, and deleting specific or all associations between objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot CRM Associations setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest) to obtain OAuth2 credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Data**
   
   Ensure you have existing deal and company records in your HubSpot CRM account. Update the following constants in `main.bal` with your actual object IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script performs the following sequence of operations:
1. Creates a default association between a deal and a company
2. Creates an association with a custom label between the deal and company
3. Reads all associations between the deal and company
4. Deletes the specific labeled association
5. Reads associations again to verify the deletion
6. Deletes all remaining associations between the deal and company
7. Reads associations one final time to confirm all associations are removed