# CRM Association Migration

This example demonstrates how to migrate company-contact associations between HubSpot CRM environments. The script reads existing associations in batch from a staging environment, creates them in a target system with proper labels, and verifies the migration was successful.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   hubspotAccessToken = "<Your HubSpot Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the migration process.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== HubSpot CRM Association Migration Example ===
Synchronizing company-contact associations from staging to production

Step 1: Reading existing company-contact associations in batch...
Batch read completed with status: COMPLETE
Number of results: 3

Step 2: Creating associations in target system with proper labels...
Batch create completed with status: COMPLETE

Step 3: Verifying associations were created correctly...

=== Migration Summary ===
1. Successfully read associations from staging environment
2. Created 3 associations in target system
3. Verified associations for migrated companies

CRM relationship synchronization completed successfully!
```