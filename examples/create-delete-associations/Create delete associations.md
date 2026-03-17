# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects using the Ballerina HubSpot CRM Associations connector. The script creates default and labeled associations between deals and companies, reads the associations, and then deletes them both individually and in bulk.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/blob/main/ballerina/Package.md#setup-guide) to obtain your OAuth2 credentials.

2. **Configuration**
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Data**
   Ensure you have existing deal and company records in your HubSpot CRM. Update the following constants in the `main.bal` file with your actual object IDs:
   - `FROM_OBJECT_ID` - Your deal ID
   - `TO_OBJECT_ID` - Your company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script performs the following operations in sequence:
1. Creates a default association between a deal and a company
2. Creates a labeled association (USER_DEFINED) between the same objects
3. Reads all associations between the deal and company
4. Deletes the specific labeled association
5. Reads associations again to verify the deletion
6. Deletes all remaining associations between the deal and company
7. Reads associations one final time to confirm all associations are removed