# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default and labeled associations, reads them, and then deletes specific and all associations between objects.

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

   > **Note:** Before running this example, ensure you have valid deal and company records in your HubSpot account. Update the `FROM_OBJECT_ID` and `TO_OBJECT_ID` constants in `main.bal` with your actual deal and company IDs respectively.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of creating, reading, and deleting associations.

```shell
bal run
```