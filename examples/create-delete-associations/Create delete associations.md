# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default and labeled associations, reads existing associations, and deletes specific or all associations between objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/ballerina-library/blob/main/ballerinax/hubspot.crm.associations/Module.md#setup-guide) to obtain your OAuth2 credentials.

2. **Configuration**
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **Update Object IDs**
   Before running the example, update the following constants in `main.bal` with valid object IDs from your HubSpot account:
   - `FROM_OBJECT_ID` - A valid deal ID
   - `TO_OBJECT_ID` - A valid company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```