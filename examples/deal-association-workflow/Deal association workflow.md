# Deal Association Workflow

This example demonstrates how to automate deal association management in HubSpot CRM by reading existing company-contact associations, creating default deal-to-company associations, and establishing custom labeled associations (like "Decision Maker") between deals and contacts for enhanced sales pipeline tracking.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   accessToken = "<Your Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the deal association workflow.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Sales Pipeline Management: Deal Association Workflow ===

Successfully initialized HubSpot CRM Associations client.

Step 1: Reading existing associations for company to identify linked contacts...
Found X contact(s) associated with the company.
...

Step 2: Creating default association between deal and company...
Default association created successfully!
...

Step 3: Creating custom labeled association between deal and primary contact...
Custom labeled association created successfully!
...

=== Workflow Summary ===
1. Retrieved existing company-contact associations for context
2. Created default deal-to-company association
3. Created labeled deal-to-contact association with 'Decision Maker' label

Sales pipeline management workflow completed successfully!
```