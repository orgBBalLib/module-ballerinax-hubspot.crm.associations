# Customer Contact Association Setup

This example demonstrates how to automate customer onboarding by establishing associations between a company and its key contacts in HubSpot CRM. The script reads existing associations, creates batch associations with specific labels for different stakeholder roles (Primary Contact, Technical Lead, Billing Contact), and retrieves the updated association list for verification.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/ballerina-library/blob/main/resources/connectors/hubspot/Setting%20Up%20Access%20Tokens.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials and sample IDs:

   ```toml
   accessToken = "<Your HubSpot Access Token>"
   companyId = "<Your Company ID>"
   primaryContactId = "<Your Primary Contact ID>"
   technicalLeadId = "<Your Technical Lead Contact ID>"
   billingContactId = "<Your Billing Contact ID>"
   ```

   > **Note:** Replace the placeholder values with actual HubSpot object IDs from your account. The company and contact IDs can be found in the HubSpot CRM interface or retrieved via the HubSpot API.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association management process.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Onboarding Association Management ===

Step 1: Checking for existing associations between company and contacts...

Step 2: Creating batch associations with specific labels...

Batch association creation completed:
Status: COMPLETE
...

Step 3: Retrieving updated association list for onboarding dashboard...

=== Onboarding Dashboard - Company Associations ===
Company ID: 12345678901
Total associated contacts: 3
...

=== Customer Onboarding Association Setup Complete ===
All relationships have been established for the enterprise customer.
```