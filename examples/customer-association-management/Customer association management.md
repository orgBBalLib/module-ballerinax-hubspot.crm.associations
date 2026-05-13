# Customer Association Management

This example demonstrates how to manage customer associations in HubSpot CRM by creating default and custom labeled associations between companies and contacts. The script initializes a HubSpot CRM Associations client, creates a default association linking a company to a sales representative, reads existing associations, batch creates multiple custom labeled associations for stakeholders (decision maker, technical contact, billing contact), and verifies all relationships.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot CRM Associations setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with the following configuration:

   ```toml
   accessToken = "<Your Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association management process.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Onboarding Association Management ===

✓ HubSpot CRM Associations client initialized successfully

--- Step 1: Creating Default Association ---
Linking new company to assigned sales representative...
Default association created successfully!
...

--- Step 2: Reading All Company Associations ---
Fetching all contact associations for the company...
Successfully retrieved company associations!
...

--- Step 3: Creating Custom Labeled Associations (Batch) ---
Creating labeled associations for stakeholder contacts...
Batch association creation completed!
...

--- Final Verification ---
Verifying all company associations after onboarding setup...
...

=== Customer Onboarding Association Management Complete ===
Summary:
  ✓ Default association created with sales representative
  ✓ Existing associations verified
  ✓ Custom labeled associations created for stakeholders
  ✓ All relationships confirmed
```

> **Note:** The sample CRM object IDs in the code (`NEW_COMPANY_ID`, `SALES_REP_CONTACT_ID`, etc.) are placeholders. In a real scenario, these IDs would be obtained from actual company and contact creation APIs in your HubSpot account.