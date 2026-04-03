# CRM Association Sync

This example demonstrates how to synchronize company-to-contact associations in HubSpot CRM. The script reads existing associations, extracts mapping data for backup purposes, recreates associations in a staging environment, and performs cleanup by archiving test associations.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/blob/main/ballerina/Package.md#setup-guide) to obtain your access token.

2. For this example, create a `Config.toml` file with your credentials:

```toml
accessToken = "<Your Access Token>"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association sync process.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== HubSpot CRM Association Sync: Company-to-Contact Relationships ===

Step 1: Reading existing company-to-contact associations...
Read operation status: COMPLETE
Number of results retrieved: 3

Step 2: Recreating associations in staging environment...
Create operation status: COMPLETE
Associations created: 2

Step 3: Cleaning up test associations (batch archive)...
Archive operation status code: 204

=== CRM Association Sync Complete ===
Summary:
  - Associations read: 3 companies processed
  - Association mappings extracted: 5
  - Associations created in staging: 2
  - Test associations archived: 2 archive requests processed

The system is now ready for final migration.
```