# CRM Association Migration

This example demonstrates how to migrate contact-company associations between two HubSpot CRM environments. The script reads existing associations from a source HubSpot account and replicates them in a target HubSpot account, preserving association types and categories.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot CRM Associations setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest) to obtain access tokens for both source and target HubSpot environments.

2. **Configuration**
   
   For this example, create a `Config.toml` file with your credentials:

   ```toml
   sourceAccessToken = "<Your Source HubSpot Access Token>"
   targetAccessToken = "<Your Target HubSpot Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the migration status of contact-company associations.

```shell
bal run
```