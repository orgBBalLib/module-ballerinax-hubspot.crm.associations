# Merger Association Management

This example demonstrates how to manage CRM contact-to-company associations during a corporate merger using the HubSpot CRM Associations API. The script reads existing associations for a batch of contacts, creates new associations linking them to an acquiring company with appropriate labels (Primary Company, Former Employer), and verifies the updates.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   accessToken = "<Your HubSpot Access Token>"
   ```

3. **Customize Contact and Company IDs**
   
   Before running, update the following constants in `main.bal` to match your HubSpot CRM data:
   - `contactIds` - Array of contact IDs to migrate
   - `acquiringCompanyId` - The target company ID for the merger
   - Association type IDs (`primaryCompanyTypeId`, `formerEmployerTypeId`) - Custom association label IDs configured in your HubSpot account

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing existing associations, newly created associations, and verification results.

```shell
bal run
```

The output will display:
- Step 1: Existing contact-to-company associations
- Step 2: New associations being created to the acquiring company
- Step 3: Verification of the updated associations with a summary of processed contacts and total associations