# Deal Association Workflow

This example demonstrates how to manage CRM associations when an enterprise deal closes by reading existing associations, creating default associations between deals and company contacts, and establishing custom labeled associations for account managers.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/docs/setup/setup.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with the following configuration. Replace the placeholder values with your actual HubSpot credentials and CRM object IDs:

   ```toml
   accessToken = "<Your Access Token>"
   dealId = "<Your Deal ID>"
   companyContactId = "<Your Company Contact ID>"
   accountManagerContactId = "<Your Account Manager Contact ID>"
   primaryAccountManagerTypeId = <Your Custom Association Type ID>
   ```

   > **Note:** The `primaryAccountManagerTypeId` should be obtained from HubSpot's association type definitions for your custom "Primary Account Manager" label.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association workflow.

```shell
bal run
```

Upon successful execution, you will see output indicating:
1. Existing associations retrieved for the deal
2. Default association created between the deal and company contact
3. Labeled association created for the Primary Account Manager