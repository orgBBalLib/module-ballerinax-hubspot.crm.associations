# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default associations, creates associations with custom labels, reads existing associations, and deletes both specific and all associations between objects.

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

3. **HubSpot CRM Data**
   
   Ensure you have valid deal and company object IDs in your HubSpot CRM account. Update the following constants in the `main.bal` file with your actual object IDs:
   - `FROM_OBJECT_ID` - Your deal object ID
   - `TO_OBJECT_ID` - Your company object ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script will perform the following operations in sequence:
1. Create a default association between a deal and a company
2. Create an association with a custom label (USER_DEFINED, associationTypeId: 3)
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations after deleting the specific label
6. Delete all remaining associations between the deal and company
7. Read associations after deleting all associations