# Create Delete Associations

This example demonstrates how to manage HubSpot CRM associations between objects (deals and companies) using the Ballerina HubSpot CRM Associations connector. The script creates default associations, creates associations with labels, reads associations, and deletes both specific and all associations between objects.

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

3. **HubSpot Object IDs**
   
   Before running the example, update the following constants in the `main.bal` file with valid object IDs from your HubSpot account:
   
   - `FROM_OBJECT_ID`: A valid Deal ID
   - `TO_OBJECT_ID`: A valid Company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```