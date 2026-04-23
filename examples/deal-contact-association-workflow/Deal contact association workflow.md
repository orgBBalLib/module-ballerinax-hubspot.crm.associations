# Deal Contact Association Workflow

This example demonstrates how to automate CRM data integrity during sales handoffs by reading existing company-to-contact associations, batch creating deal-to-contact associations, and verifying the associations were successfully created in HubSpot.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/docs/setup/setup.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials and record IDs:

   ```toml
   accessToken = "<Your Access Token>"
   companyId = "<Your Company ID>"
   dealId = "<Your Deal ID>"
   ```

   > **Note:** Replace the placeholder values with your actual HubSpot access token and the IDs of the company and deal you want to associate. In production scenarios, these IDs would typically come from your CRM data or webhook events.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association workflow.

```shell
bal run
```

The workflow will:
1. Read existing associations between the specified company and its contacts
2. Batch create associations between the deal and all company contacts
3. Verify that all associations were successfully created
4. Display a summary of the workflow results