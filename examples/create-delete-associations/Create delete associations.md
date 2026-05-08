# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default associations, creates associations with labels, reads associations, and deletes both specific and all associations between objects.

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
   
   Ensure you have existing deal and company records in your HubSpot CRM. Update the following constants in `main.bal` with valid object IDs from your HubSpot account:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your Deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your Company ID
   ```

## Run the Example

Execute the following command to run the example. The script will perform a series of association operations and print the results to the console.

```shell
bal run
```

Upon successful execution, you will see output showing:
- Creation of default associations between a deal and a company
- Creation of associations with custom labels
- Reading of current associations
- Deletion of specific labeled associations
- Deletion of all associations between the objects