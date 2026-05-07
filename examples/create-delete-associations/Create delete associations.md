# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot by creating default and labeled associations between deals and companies, reading those associations, and then deleting them both selectively and completely.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain OAuth2 credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Data**
   
   Ensure you have existing deal and company records in your HubSpot CRM. Update the following constants in `main.bal` with your actual object IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script will perform the following operations in sequence:
1. Create a default association between a deal and a company
2. Create a labeled association (USER_DEFINED, associationTypeId: 3) between the same objects
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations again to verify the deletion
6. Delete all remaining associations between the deal and company
7. Read associations one final time to confirm complete removal