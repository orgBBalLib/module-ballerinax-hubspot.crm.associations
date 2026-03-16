# Examples

The `hubspot.crm.associations` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples), covering use cases like creating and deleting associations, managing deal-contact association workflows, and creating and reading associations.

1. [Create delete associations](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples/create-delete-associations) - Demonstrate how to create and delete associations between CRM objects in HubSpot.

2. [Deal contact association workflow](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples/deal-contact-association-workflow) - Implement a workflow to manage associations between deals and contacts in HubSpot CRM.

3. [Create read associations](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples/create-read-associations) - Create associations between CRM objects and read the existing associations.

## Prerequisites

1. Generate HubSpot credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/hubspot.crm.associations/latest#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    token = "<Access Token>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```