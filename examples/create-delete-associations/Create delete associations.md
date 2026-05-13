# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) by creating default associations, creating labeled associations, reading associations, and deleting specific or all associations between objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot CRM Associations setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest) to obtain OAuth2 credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Objects**
   
   Ensure you have existing deal and company records in your HubSpot account. Update the following constants in the code with your actual object IDs:
   
   - `FROM_OBJECT_ID`: Your deal object ID
   - `TO_OBJECT_ID`: Your company object ID

## Run the Example

Execute the following command to run the example. The script will perform a sequence of operations and print the results to the console:

```shell
bal run
```

The script will:
1. Create a default association between a deal and a company
2. Create a labeled association (USER_DEFINED) between the same objects
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations again to verify deletion
6. Delete all remaining associations between the objects
7. Read associations one final time to confirm complete removal