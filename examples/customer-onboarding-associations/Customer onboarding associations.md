# Customer Onboarding Associations

This example demonstrates how to manage customer onboarding associations in HubSpot CRM using the Ballerina HubSpot CRM Associations connector. The script creates default associations between companies and contacts, reads existing deal associations, and creates batch associations with custom labels for multiple deals.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   accessToken = "<Your Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association management process.

```shell
bal run
```

The script will:
1. Create a default association between a company and a sales rep contact
2. Read existing deal associations for the company
3. Create batch associations with custom labels (Primary Deal, Upsell Opportunity) for multiple deals
4. Display a summary of all created associations