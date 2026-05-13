# Customer Onboarding Associations

This example demonstrates how to manage CRM associations during customer onboarding using the HubSpot CRM Associations API. The script creates associations between a company, its primary contact, and an initial deal, then verifies the complete relationship graph.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   accessToken = "<Your Access Token>"
   ```

3. **Update Record IDs**
   
   Before running the example, update the following constants in `main.bal` with actual HubSpot record IDs from your account:
   
   ```ballerina
   const string NEW_COMPANY_ID = "12345678901";      // Your company ID
   const string PRIMARY_CONTACT_ID = "23456789012";  // Your contact ID
   const string INITIAL_DEAL_ID = "34567890123";     // Your deal ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Onboarding Association Management ===

HubSpot CRM Associations client initialized successfully.

Step 1: Creating association between Company and Primary Contact...
  Company ID: 12345678901
  Contact ID: 23456789012
  Association created successfully!
  ...

Step 2: Creating association between Primary Contact and Initial Deal...
  ...

Step 3: Creating direct association between Company and Initial Deal...
  ...

Step 4: Verifying the complete relationship graph for the company...
  ...

=== Customer Onboarding Association Summary ===
Company ID: 12345678901
  └── Associated Contacts: 1
  └── Associated Deals: 1
Primary Contact ID: 23456789012
  └── Associated Deals: 1

Customer onboarding association management completed successfully!
All relationships have been established for the new enterprise customer.
```