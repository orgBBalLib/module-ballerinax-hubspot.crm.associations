# Deal Contact Association Workflow

This example demonstrates how to automate the association of a closed enterprise deal with all contacts belonging to a company in HubSpot CRM. The workflow retrieves company-to-contact associations, creates deal-to-contact associations in batch, and verifies the created associations for customer success team handoff.

## Prerequisites

1. **HubSpot CRM Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/ballerina-library/blob/main/ballerinax/hubspot.crm.associations/Module.md#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   accessToken = "<Your Access Token>"
   companyId = "<Your Company ID>"
   dealId = "<Your Deal ID>"
   ```

   - `accessToken`: Your HubSpot private app access token with CRM associations permissions
   - `companyId`: The HubSpot ID of the company whose contacts you want to associate with the deal
   - `dealId`: The HubSpot ID of the deal to associate contacts with

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Onboarding Association Workflow ===
This workflow associates a closed enterprise deal with all company contacts.

✓ HubSpot CRM Associations client initialized successfully.

--- Step 1: Retrieving Company-to-Contact Associations ---
Company ID: 12345678
Found 3 contact(s) associated with the company.

--- Step 2: Creating Deal-to-Contact Associations ---
Deal ID: 98765432
Creating 3 deal-to-contact association(s)...
✓ All associations created successfully!

--- Step 3: Verifying Deal-to-Contact Associations ---
Verification batch status: COMPLETE

=== Workflow Complete ===
Summary for Customer Success Team Handoff:
  • Deal ID: 98765432
  • Company ID: 12345678
  • Total Contacts Associated: 3

✓ All deal-to-contact relationships are properly established.
  The customer success team can now access all relevant contacts from the deal record.
```