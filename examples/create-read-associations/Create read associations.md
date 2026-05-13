# Create Read Associations

This example demonstrates how to create and read associations between HubSpot CRM objects (deals and companies) using both default and custom association labels, then retrieve the created associations.

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

3. **HubSpot CRM Objects**
   
   Ensure you have existing deals and companies in your HubSpot CRM account. Update the following constants in the code with your actual object IDs:
   - `FROM_OBJECT_ID_1` and `FROM_OBJECT_ID_2` - Your deal IDs
   - `TO_OBJECT_ID_1` and `TO_OBJECT_ID_2` - Your company IDs

## Run the Example

Execute the following command to run the example. The script will create associations between deals and companies, then read and print the association details to the console.

```shell
bal run
```