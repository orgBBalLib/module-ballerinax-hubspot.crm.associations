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

3. **HubSpot Object IDs**
   
   Before running this example, ensure you have valid deal and company IDs in your HubSpot account. Update the following constants in the `main.bal` file with your actual object IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID_1 = "46989749974";  // Your first deal ID
   const string TO_OBJECT_ID_1 = "43500581578";    // Your first company ID
   const string FROM_OBJECT_ID_2 = "46989749975";  // Your second deal ID
   const string TO_OBJECT_ID_2 = "43626089171";    // Your second company ID
   ```

## Run the Example

Execute the following command to run the example. The script will create associations between deals and companies, then read and display the created associations.

```shell
bal run
```