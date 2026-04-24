# Create Read Associations

This example demonstrates how to create and read associations between HubSpot CRM objects using the HubSpot CRM Associations connector. The script creates both default and custom-labeled associations between deals and companies, then reads back the created associations.

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
   
   Ensure you have existing deals and companies in your HubSpot account. Update the following constants in the code with valid object IDs from your HubSpot instance:
   - `FROM_OBJECT_ID_1` and `FROM_OBJECT_ID_2` - Valid deal IDs
   - `TO_OBJECT_ID_1` and `TO_OBJECT_ID_2` - Valid company IDs

## Run the Example

Execute the following command to run the example. The script will create associations and print the results to the console.

```shell
bal run
```

Upon successful execution, you will see output showing:
- The response from creating default associations between deals and companies
- The response from creating custom-labeled associations
- The read responses showing all associations for each deal with companies