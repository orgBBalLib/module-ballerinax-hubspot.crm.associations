# Create Delete Associations

This example demonstrates how to manage HubSpot CRM associations between objects (deals and companies) using the Ballerina HubSpot CRM Associations connector. The script creates default associations, creates labeled associations, reads associations, and then deletes specific and all associations between the objects.

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

3. **Object IDs**
   
   Before running the example, update the following constants in `main.bal` with valid object IDs from your HubSpot account:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your Deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your Company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script will perform the following operations in sequence:
1. Create a default association between a deal and a company
2. Create a labeled association (USER_DEFINED) between the same objects
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations after the specific deletion
6. Delete all remaining associations between the objects
7. Read associations after deleting all associations