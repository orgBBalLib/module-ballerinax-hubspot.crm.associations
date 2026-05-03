# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default associations, creates associations with custom labels, reads existing associations, and deletes both specific and all associations between objects.

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
   Before running this example, ensure you have valid HubSpot object IDs for deals and companies. Update the following constants in `main.bal` with your actual object IDs:
   - `FROM_OBJECT_ID` - Your deal ID
   - `TO_OBJECT_ID` - Your company ID

## Run the Example

Execute the following command to run the example. The script will perform association operations and print the results to the console.

```shell
bal run
```

The script will execute the following operations in sequence:
1. Create a default association between a deal and a company
2. Create an association with a custom label between the deal and company
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations again to verify deletion
6. Delete all remaining associations between the deal and company
7. Read associations one final time to confirm all associations are removed