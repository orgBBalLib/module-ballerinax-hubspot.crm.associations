# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) by creating default associations, creating associations with labels, reading associations, and deleting specific or all associations between objects.

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
   
   Before running this example, ensure you have valid HubSpot object IDs. Update the following constants in the `main.bal` file with your actual deal and company IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "<Your Deal ID>";
   const string TO_OBJECT_ID = "<Your Company ID>";
   ```

## Run the Example

Execute the following command to run the example. The script will perform the following operations and print the results to the console:

1. Create a default association between a deal and a company
2. Create an association with a custom label between the deal and company
3. Read all associations between the deal and companies
4. Delete the specific labeled association
5. Read associations after deleting the specific label
6. Delete all associations between the deal and company
7. Read associations after deleting all

```shell
bal run
```