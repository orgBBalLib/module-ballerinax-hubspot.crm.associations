# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot by creating default and labeled associations between deals and companies, reading those associations, and then deleting them both selectively and completely.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/docs/setup/setup.md) to obtain OAuth2 credentials.

2. **Configuration**
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Data**
   Ensure you have existing deal and company records in your HubSpot CRM. Update the following constants in the code with valid object IDs from your HubSpot account:
   - `FROM_OBJECT_ID` - A valid deal ID
   - `TO_OBJECT_ID` - A valid company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script performs the following operations in sequence:
1. Creates a default association between a deal and a company
2. Creates a labeled (user-defined) association between the same deal and company
3. Reads all associations between the deal and company
4. Deletes the specific labeled association
5. Reads associations again to confirm the labeled association was removed
6. Deletes all remaining associations between the deal and company
7. Reads associations one final time to confirm all associations were removed