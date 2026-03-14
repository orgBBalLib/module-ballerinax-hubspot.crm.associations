## Overview

[HubSpot](https://www.hubspot.com/) is a cloud-based customer relationship management (CRM) platform that helps businesses grow by providing tools for marketing, sales, customer service, and content management in one unified system.

The `ballerinax/hubspot.crm.associations` package offers APIs to connect and interact with [HubSpot CRM Associations API](https://developers.hubspot.com/docs/api/crm/associations) endpoints, specifically based on [HubSpot CRM Associations API v4](https://developers.hubspot.com/docs/api/crm/associations).
## Setup guide

To use the HubSpot CRM Associations connector, you must have access to the HubSpot API through a [HubSpot developer account](https://developers.hubspot.com/) and obtain an API access token. If you do not have a HubSpot account, you can sign up for one [here](https://app.hubspot.com/signup-hubspot/crm).

### Step 1: Create a HubSpot Account

1. Navigate to the [HubSpot website](https://www.hubspot.com/) and sign up for an account or log in if you already have one.

2. If you intend to use private apps for API access, note that creating private apps requires a HubSpot account with Super Admin permissions. Additionally, some API features may require a Professional or Enterprise plan subscription depending on the specific endpoints you need to access.

### Step 2: Generate an API Access Token

1. Log in to your HubSpot account.

2. In the main navigation bar, click the settings icon (gear icon) to access your account settings.

3. In the left sidebar menu, navigate to Integrations > Private Apps.

4. Click Create a private app.

5. On the Basic Info tab, enter a name and description for your private app.

6. Navigate to the Scopes tab and select the required scopes for CRM associations (such as `crm.objects.contacts.read`, `crm.objects.contacts.write`, and other relevant object scopes).

7. Click Create app in the top right corner, then review the information and click Continue creating.

8. Once the app is created, navigate to the Access token section and click Show token to reveal your access token.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again after you navigate away from the page for security reasons.
## Quickstart

To use the `HubSpot CRM Associations` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/oauth2;
import ballerinax/hubspot.crm.associations as hscrmassoc;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained credentials:

```toml
clientId = "<Your_Client_Id>"
clientSecret = "<Your_Client_Secret>"
refreshToken = "<Your_Refresh_Token>"
```

2. Create a `hscrmassoc:ConnectionConfig` and initialize the client:

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

final hscrmassoc:Client hscrmassocClient = check new ({
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Associate records with default association type

```ballerina
public function main() returns error? {
    hscrmassoc:BatchInputPublicDefaultAssociationMultiPost batchAssociations = {
        inputs: [
            {
                'from: {
                    id: "12345"
                },
                to: {
                    id: "67890"
                }
            }
        ]
    };

    hscrmassoc:BatchResponsePublicDefaultAssociation response = check hscrmassocClient->/associations/["contacts"]/["companies"]/batch/associate/default.post(batchAssociations);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `hubspot.crm.associations` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples), covering the following use cases:

1. [Create delete associations](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples/create-delete-associations) - Demonstrates how to create and delete associations between CRM records using Ballerina connector for HubSpot CRM Associations.
2. [Customer onboarding associations](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples/customer-onboarding-associations) - Illustrates managing customer onboarding workflows by associating contacts, companies, and deals.
3. [Create read associations](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/examples/create-read-associations) - Shows how to create associations and retrieve existing associations between CRM objects.