# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default associations, creates associations with labels, reads associations, and deletes both specific and all associations between objects.

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
   
   Ensure you have valid deal and company object IDs in your HubSpot account. Update the following constants in the code if needed:
   - `FROM_OBJECT_ID` - The deal ID
   - `TO_OBJECT_ID` - The company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will perform the following operations sequentially:
1. Create a default association between a deal and a company
2. Create an association with a custom label between the deal and company
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations after the specific deletion
6. Delete all remaining associations between the deal and company
7. Read associations after deleting all associations