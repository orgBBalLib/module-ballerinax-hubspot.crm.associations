# CRM Contact Association Management

This example demonstrates how to manage contact-company relationships in HubSpot CRM by auditing existing associations, creating new associations with onboarded companies, and removing outdated associations to maintain clean and accurate CRM data.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   accessToken = "<Your Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the audit of existing associations, creation of new associations, and removal of outdated ones.

```shell
bal run
```