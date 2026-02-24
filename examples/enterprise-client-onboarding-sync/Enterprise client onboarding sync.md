# Enterprise Client Onboarding Sync

This example demonstrates how to synchronize CRM relationships during enterprise client onboarding by retrieving existing associations, creating batch company-deal associations, and establishing default contact-deal associations using the HubSpot CRM Associations API.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   accessToken = "<Your HubSpot Access Token>"
   ```

3. **Update Sample IDs**
   
   The example uses placeholder IDs for demonstration purposes. Before running, update the following constants in `main.bal` with your actual HubSpot record IDs:
   
   - `NEW_COMPANY_ID` - Your company record ID
   - `PRIMARY_CONTACT_ID` - Your primary contact record ID
   - `DEAL_ID_PRODUCT_LINE_A`, `DEAL_ID_PRODUCT_LINE_B`, `DEAL_ID_PRODUCT_LINE_C` - Your deal record IDs

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the status of each association operation.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Enterprise Client Onboarding: CRM Relationship Synchronization ===

✓ HubSpot CRM Associations client initialized successfully

--- Step 1: Retrieving Existing Company-Contact Associations ---
...
--- Step 2: Creating Batch Company-Deal Associations ---
...
--- Step 3: Creating Default Contact-Deal Associations ---
...
=== Enterprise Client Onboarding Complete ===
```