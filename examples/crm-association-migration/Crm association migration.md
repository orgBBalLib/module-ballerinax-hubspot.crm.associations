# CRM Association Migration

This example demonstrates how to migrate and restructure CRM relationship data in HubSpot by batch reading existing contact-to-company associations and creating new labeled associations with custom relationship types such as "Primary Decision Maker" and "Technical Contact."

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/docs/setup/setup.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   accessToken = "<Your Access Token>"
   ```

   > **Note:** Ensure that your HubSpot access token has the necessary scopes for reading and creating CRM associations.

## Run the Example

Execute the following command to run the migration script. The script will print its progress to the console, showing existing associations being read and new labeled associations being created.

```shell
bal run
```

Upon successful execution, you will see output displaying:
- Existing contact-to-company associations
- Newly created labeled associations with custom relationship types
- A summary of the migration results