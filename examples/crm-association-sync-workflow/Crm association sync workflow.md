# CRM Association Sync Workflow

This example demonstrates how to synchronize contact-to-company associations in HubSpot CRM by reading existing associations, analyzing them against business rules, and creating new labeled associations in batch operations.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   accessToken = "<Your HubSpot Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the analysis of existing associations and the creation of new ones.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== HubSpot CRM Association Sync Workflow ===

Step 1: Preparing to read existing contact-to-company associations...
Contact IDs to analyze: ["101", "102", "103", "104"]

Step 2: Reading existing contact-to-company associations...
Batch read status: COMPLETE
...

Step 5: Creating new labeled associations...
Batch create status: COMPLETE
...

=== Association Sync Complete ===
Total associations created: 4
```