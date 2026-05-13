// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/os;
import ballerina/test;
import hubspot.crm.associations.mock.server as _;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string token = isLiveServer ? os:getEnv("HUBSPOT_TOKEN") : "test_token";
configurable string serviceUrl = isLiveServer ? "https://api.hubapi.com/crm/v4" : "http://localhost:9090/crm/v4";

ConnectionConfig config = {auth: {token: token}};
final Client hubspotClient = check new Client(config, serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeleteAssociationsBetweenTwoRecords() returns error? {
    error? response = check hubspotClient->/objects/["contacts"]/["12345"]/associations/["companies"]/["67890"].delete();
    test:assertTrue(response is (), "Expected no error on successful delete");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetAssociationsByObjectType() returns error? {
    CollectionResponseMultiAssociatedObjectWithLabelForwardPaging response = check hubspotClient->/objects/["contacts"]/["12345"]/associations/["companies"].get();
    test:assertTrue(response.results.length() > 0, "Expected a non-empty results array");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPostBatchArchiveAssociations() returns error? {
    BatchInputPublicAssociationMultiArchive payload = {
        inputs: [
            {
                'from: {id: "12345"},
                to: [{id: "67890"}]
            }
        ]
    };
    error? response = check hubspotClient->/associations/["contacts"]/["companies"]/batch/archive.post(payload);
    test:assertTrue(response is (), "Expected no error on successful batch archive");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPostBatchAssociateDefault() returns error? {
    BatchInputPublicDefaultAssociationMultiPost payload = {
        inputs: [
            {
                'from: {id: "12345"},
                to: {id: "67890"}
            }
        ]
    };
    BatchResponsePublicDefaultAssociation response = check hubspotClient->/associations/["contacts"]/["companies"]/batch/associate/default.post(payload);
    test:assertTrue(response.results.length() > 0, "Expected a non-empty results array");
    StandardError[]? errors = response.errors;
    test:assertTrue(errors is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPostBatchCreateLabelledAssociations() returns error? {
    BatchInputPublicAssociationMultiPost payload = {
        inputs: [
            {
                'from: {id: "12345"},
                to: {id: "67890"},
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 1
                    }
                ]
            }
        ]
    };
    BatchResponseLabelsBetweenObjectPair|BatchResponseLabelsBetweenObjectPairWithErrors response = check hubspotClient->/associations/["contacts"]/["companies"]/batch/create.post(payload);
    test:assertTrue(response.results.length() > 0, "Expected a non-empty results array");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPostBatchLabelsArchive() returns error? {
    BatchInputPublicAssociationMultiPost payload = {
        inputs: [
            {
                'from: {id: "12345"},
                to: {id: "67890"},
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 1
                    }
                ]
            }
        ]
    };
    error? response = check hubspotClient->/associations/["contacts"]/["companies"]/batch/labels/archive.post(payload);
    test:assertTrue(response is (), "Expected no error on successful batch labels archive");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPostBatchReadAssociations() returns error? {
    BatchInputPublicFetchAssociationsBatchRequest payload = {
        inputs: [
            {
                id: "12345"
            }
        ]
    };
    BatchResponsePublicAssociationMultiWithLabel|BatchResponsePublicAssociationMultiWithLabelWithErrors response = check hubspotClient->/associations/["contacts"]/["companies"]/batch/read.post(payload);
    test:assertTrue(response.results.length() > 0, "Expected a non-empty results array");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPostHighUsageReport() returns error? {
    ReportCreationResponse response = check hubspotClient->/associations/usage/high\-usage\-report/[98765432].post();
    test:assertTrue(response.userId != 0, "Expected userId to be present");
    test:assertTrue(response.userEmail != "", "Expected userEmail to be present");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPutDefaultAssociation() returns error? {
    BatchResponsePublicDefaultAssociation response = check hubspotClient->/objects/["contacts"]/["12345"]/associations/default/["companies"]/["67890"].put();
    test:assertTrue(response.results.length() > 0, "Expected a non-empty results array");
    StandardError[]? errors = response.errors;
    test:assertTrue(errors is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPutLabelledAssociation() returns error? {
    AssociationSpec[] payload = [
        {
            associationCategory: "HUBSPOT_DEFINED",
            associationTypeId: 1
        }
    ];
    LabelsBetweenObjectPair response = check hubspotClient->/objects/["contacts"]/["12345"]/associations/["companies"]/["67890"].put(payload);
    test:assertTrue(response.fromObjectId != 0, "Expected fromObjectId to be present");
    test:assertTrue(response.toObjectId != 0, "Expected toObjectId to be present");
    test:assertTrue(response.labels.length() > 0, "Expected a non-empty labels array");
}