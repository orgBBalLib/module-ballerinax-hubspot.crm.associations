# Enterprise Onboarding Associations

This example demonstrates how to automate the customer onboarding process by creating and managing associations between HubSpot CRM objects. The script establishes relationships between a company and its key contacts (decision maker, technical lead, billing contact) and assigns an account manager for customer success handoff.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   accessToken = "<Your HubSpot Access Token>"
   ```

3. **Update Sample IDs**
   
   Before running the example, update the following constants in `main.bal` with your actual HubSpot object IDs:
   
   - `COMPANY_ID` - The ID of the company being onboarded
   - `DECISION_MAKER_CONTACT_ID` - The contact ID of the decision maker
   - `TECHNICAL_LEAD_CONTACT_ID` - The contact ID of the technical lead
   - `BILLING_CONTACT_ID` - The contact ID of the billing contact
   - `ACCOUNT_MANAGER_USER_ID` - The user ID of the assigned account manager

## Run the Example

Execute the following command to run the example. The script will print its progress to the console as it performs each step of the onboarding workflow.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Onboarding Association Workflow ===

Initializing HubSpot CRM Associations client...
Client initialized successfully.

--- Step 1: Reading Existing Company-Contact Associations ---
...

--- Step 2: Creating Batch Associations (Company to Contacts) ---
Batch associations created successfully!
...

--- Step 3: Creating Default Association (Company to Account Manager) ---
Default association created successfully!
...

=== Customer Onboarding Association Workflow Complete ===
Summary:
  - Verified existing company-contact associations
  - Created associations with 3 key contacts (Decision Maker, Technical Lead, Billing)
  - Established account manager ownership for customer success handoff

All stakeholder relationships are now properly documented in HubSpot.
```