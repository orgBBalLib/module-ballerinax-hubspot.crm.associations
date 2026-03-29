# Create Read Associations

This example demonstrates how to create and read associations between HubSpot CRM objects (deals and companies) using both default and custom association labels, then retrieve the created associations.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/ballerinax-openapi-connectors/blob/main/docs/setup/hubspot/crm/associations.md) to obtain OAuth2 credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot Objects**
   
   Ensure you have existing deals and companies in your HubSpot account. Update the following constants in `main.bal` with your actual object IDs:
   
   - `FROM_OBJECT_ID_1` and `FROM_OBJECT_ID_2` - Your deal IDs
   - `TO_OBJECT_ID_1` and `TO_OBJECT_ID_2` - Your company IDs

## Run the Example

Execute the following command to run the example. The script will create associations between deals and companies, then read and display the created associations.

```shell
bal run
```

The script will output:
- Response from creating default associations between deals and companies
- Response from creating custom labeled associations
- All associations for the specified deal objects with companies