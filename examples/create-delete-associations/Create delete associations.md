# Create and Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default and labeled associations, reads them, and then deletes both specific and all associations between the objects.

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

3. **Object IDs**
   Before running the example, update the `FROM_OBJECT_ID` and `TO_OBJECT_ID` constants in `main.bal` with valid deal and company IDs from your HubSpot account.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script will perform the following operations in sequence:
1. Create a default association between a deal and a company
2. Create a labeled association (USER_DEFINED) between the same objects
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations again to verify deletion
6. Delete all remaining associations between the objects
7. Read associations one final time to confirm all are removed