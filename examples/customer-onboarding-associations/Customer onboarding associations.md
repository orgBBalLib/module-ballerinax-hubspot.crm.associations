# Customer Onboarding Associations

This example demonstrates how to associate company, contact, and deal records during customer onboarding using the HubSpot CRM Associations API. The script creates default associations between a company and contact, verifies the association, and then creates a custom labeled association between the company and a deal.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials and CRM record IDs:

   ```toml
   accessToken = "<Your Access Token>"
   companyId = "<Your Company ID>"
   primaryContactId = "<Your Primary Contact ID>"
   dealId = "<Your Deal ID>"
   ```

   > **Note:** The `companyId`, `primaryContactId`, and `dealId` should be valid record IDs from your HubSpot CRM. You can find these IDs in the HubSpot UI or by querying the respective CRM APIs.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console as it creates and verifies associations.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Onboarding Association Workflow ===

✓ HubSpot CRM Associations client initialized successfully

Step 1: Creating default association between Company and Primary Contact...
   Status: COMPLETE
   ...
✓ Default association created successfully

Step 2: Retrieving all associations for the Company to verify Contact link...
   ...
✓ Contact association verification completed successfully

Step 3: Creating custom labeled association between Company and Deal (Primary Deal)...
   ...
✓ Custom labeled association (Primary Deal) created successfully

=== Customer Onboarding Association Workflow Complete ===
```