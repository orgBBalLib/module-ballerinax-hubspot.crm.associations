# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default associations, creates associations with custom labels, reads existing associations, and deletes both specific and all associations between objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain OAuth2 credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Data**
   
   Ensure you have valid Deal and Company object IDs in your HubSpot account. Update the following constants in the code with your actual object IDs:
   - `FROM_OBJECT_ID` - Your Deal ID
   - `TO_OBJECT_ID` - Your Company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script will sequentially:
1. Create a default association between the specified deal and company
2. Create an association with a custom label (USER_DEFINED, associationTypeId: 3)
3. Read and display all associations between the deal and company
4. Delete the specific labeled association
5. Read associations again to confirm the labeled association was removed
6. Delete all remaining associations between the deal and company
7. Read associations one final time to confirm all associations were removed