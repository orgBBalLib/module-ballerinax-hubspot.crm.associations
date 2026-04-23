# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default and labeled associations, reads them, and then deletes specific and all associations between the objects.

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
   
   Ensure you have valid deal and company object IDs in your HubSpot CRM account. Update the following constants in the `main.bal` file with your actual object IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```