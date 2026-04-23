# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot by creating default associations, creating associations with labels, reading associations, and deleting associations between deals and companies using the HubSpot CRM Associations connector.

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

3. **HubSpot CRM Data**
   Ensure you have existing deal and company records in your HubSpot CRM. Update the following constants in the code with your actual object IDs:
   - `FROM_OBJECT_ID` - Your deal ID
   - `TO_OBJECT_ID` - Your company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script performs the following operations sequentially:
1. Creates a default association between a deal and a company
2. Creates an association with a user-defined label between the deal and company
3. Reads all associations between the deal and company
4. Deletes the specific labeled association
5. Reads associations again to verify the deletion
6. Deletes all remaining associations between the deal and company
7. Reads associations one final time to confirm complete removal