# CRM Contact Association Management

This example demonstrates how to manage contact-to-company associations in HubSpot CRM using the Ballerina HubSpot CRM Associations connector. The script retrieves existing associations, creates new labeled associations (such as "Primary Decision Maker" and "Technical Contact"), removes outdated associations, and verifies the final association state.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain your access token.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   accessToken = "<Your HubSpot Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association management workflow.

```shell
bal run
```