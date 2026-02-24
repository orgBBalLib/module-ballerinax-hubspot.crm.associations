# Create Delete Associations

This example demonstrates how to create, read, and delete associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script performs a complete lifecycle of association management including creating default associations, creating labeled associations, reading associations, and deleting both specific and all associations.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/blob/main/ballerina/Package.md#setup-guide) to obtain OAuth2 credentials.

2. **Configuration**
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Objects**
   Ensure you have existing deal and company records in your HubSpot CRM account. Update the following constants in `main.bal` with your actual object IDs:
   - `FROM_OBJECT_ID` - The ID of your deal record
   - `TO_OBJECT_ID` - The ID of your company record

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```