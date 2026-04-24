# Customer Onboarding Associations

This example demonstrates how to manage CRM associations during customer onboarding in HubSpot. The script checks existing associations for a company, then creates default and custom labeled associations between the company and its related contacts and deals.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with the following configuration. Replace the placeholder values with your actual HubSpot object IDs:

   ```toml
   accessToken = "<Your Access Token>"
   newCompanyId = "<Your Company ID>"
   primaryContactId = "<Your Primary Contact ID>"
   primaryDealId = "<Your Primary Deal ID>"
   upsellDealId = "<Your Upsell Deal ID>"
   ```

   > **Note:** You can obtain the object IDs from your HubSpot CRM dashboard by navigating to the respective company, contact, or deal records.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the status of association checks and creations.

```shell
bal run
```

Upon successful execution, you will see output indicating:
- Existing associations check results for the company
- Default association creation between the company and primary contact
- Custom labeled associations created for primary deal and upsell opportunity