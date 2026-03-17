# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot by creating default and labeled associations between deals and companies, reading those associations, and then deleting them both individually and in bulk.

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

3. **HubSpot CRM Records**
   
   Ensure you have existing Deal and Company records in your HubSpot CRM. Update the following constants in `main.bal` with your actual record IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your Deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your Company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will perform the following operations in sequence:

1. Create a default association between a deal and a company
2. Create a labeled association (USER_DEFINED) between the same deal and company
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations again to confirm the labeled association was removed
6. Delete all remaining associations between the deal and company
7. Read associations one final time to confirm all associations were removed