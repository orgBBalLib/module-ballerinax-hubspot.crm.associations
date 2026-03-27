# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot by creating default and labeled associations between deals and companies, reading existing associations, and deleting specific or all associations between objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/blob/main/ballerina/Package.md#setup-guide) to obtain OAuth2 credentials.

2. **Configuration**
   
   For this example, create a `Config.toml` file with your credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **Update Object IDs**
   
   Before running the example, update the following constants in `main.bal` with valid object IDs from your HubSpot account:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Replace with a valid Deal ID
   const string TO_OBJECT_ID = "43500581578";    // Replace with a valid Company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of creating, reading, and deleting associations.

```shell
bal run
```