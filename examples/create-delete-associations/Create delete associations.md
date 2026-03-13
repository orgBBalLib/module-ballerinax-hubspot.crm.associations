# Create Delete Associations

This example demonstrates how to manage CRM associations in HubSpot by creating default and labeled associations between deals and companies, reading those associations, and then deleting them (both specific labeled associations and all associations).

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/blob/main/ballerina/Package.md#setup-guide) to obtain your OAuth2 credentials (Client ID, Client Secret, and Refresh Token).

2. **HubSpot CRM Data**
   > Ensure you have existing Deal and Company records in your HubSpot CRM. Update the `FROM_OBJECT_ID` and `TO_OBJECT_ID` constants in the code with valid IDs from your HubSpot account.

3. For this example, create a `Config.toml` file with your credentials:

```toml
clientId = "<Your Client ID>"
clientSecret = "<Your Client Secret>"
refreshToken = "<Your Refresh Token>"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of creating, reading, and deleting associations between deals and companies.

```shell
bal run
```