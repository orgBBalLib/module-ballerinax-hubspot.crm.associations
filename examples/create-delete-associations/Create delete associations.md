# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot using the Ballerina HubSpot CRM Associations connector. The script creates default and labeled associations between deals and companies, reads the associations, and then deletes them both specifically and entirely.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot CRM Associations setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest) to obtain your OAuth2 credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with the following configuration:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Data**
   
   Ensure you have existing deal and company records in your HubSpot CRM. Update the following constants in `main.bal` with your actual object IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

Upon successful execution, you will see output showing:
- Creation of a default association between the deal and company
- Creation of a labeled association with a user-defined association type
- Reading of associations between the objects
- Deletion of specific labeled associations
- Deletion of all remaining associations