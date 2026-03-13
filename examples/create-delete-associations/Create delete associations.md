# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot by creating default and labeled associations between deals and companies, reading existing associations, and deleting specific or all associations between objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/ballerina-central/blob/main/resources/connector-guides/hubspot.crm.associations/setup/setup.md) to obtain OAuth2 credentials.

2. **Configuration**
   
   For this example, create a `Config.toml` file with your credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

   > **Note:** You will also need valid HubSpot object IDs for deals and companies. Update the `FROM_OBJECT_ID` and `TO_OBJECT_ID` constants in the code with your actual object IDs.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of each association operation.

```shell
bal run
```

The script will perform the following operations in sequence:
1. Create a default association between a deal and a company
2. Create a labeled association between the same deal and company
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations after deleting the labeled one
6. Delete all remaining associations between the deal and company
7. Read associations to confirm all have been removed