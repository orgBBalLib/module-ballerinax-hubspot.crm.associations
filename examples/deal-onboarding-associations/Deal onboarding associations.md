# Deal Onboarding Associations

This example demonstrates how to automate customer onboarding association workflows in HubSpot CRM. The script reads existing deal-contact associations, creates default associations between deals and companies, and establishes labeled associations with contacts to provide relationship context for sales-to-customer-success handoffs.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/ballerina-library/blob/main/library-templates/hubspot/resources/setup.md) to obtain your access token.

2. **Configuration**

   Create a `Config.toml` file in the project root directory with your HubSpot credentials:

   ```toml
   accessToken = "<Your Access Token>"
   ```

3. **HubSpot Custom Association Labels**

   This example uses custom association type IDs for labeled associations (Decision Maker and Technical Contact). Ensure these custom association labels are pre-configured in your HubSpot organization, or update the constant values in the code to match your existing label IDs.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association workflow.

```bash
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Onboarding Association Workflow ===
Processing closed-won deal associations...

Step 1: Reading existing associations between deal and contacts...
Existing associations fetch status: COMPLETE
...

Step 2: Creating default association between deal and primary company...
Default association creation status: COMPLETE
...

Step 3: Creating labeled associations between deal and contacts...
Adding relationship context for sales-to-customer-success handoff...
...

=== Workflow Complete ===
Customer onboarding association workflow completed successfully!
```