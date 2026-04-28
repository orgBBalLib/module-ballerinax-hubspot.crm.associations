# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default and labeled associations, reads existing associations, and deletes specific or all associations between objects.

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

3. **Object IDs**
   
   Before running this example, ensure you have valid HubSpot object IDs for a deal and a company. Update the following constants in the `main.bal` file with your actual object IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your Deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your Company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will perform the following operations sequentially:

1. Create a default association between a deal and a company
2. Create a labeled association (USER_DEFINED) between the same deal and company
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations after deleting the labeled association
6. Delete all remaining associations between the deal and company
7. Read associations after deleting all associations