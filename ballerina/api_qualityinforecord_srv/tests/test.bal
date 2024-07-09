// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.org).
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

import sap.s4hana.api_qualityinforecord_srv.mock as _;

import ballerina/log;
import ballerina/os;
import ballerina/test;

configurable boolean isTestOnLiveServer = os:getEnv("IS_TEST_ON_S4HANA_SERVER") == "false";

configurable string hostname = isTestOnLiveServer ? os:getEnv("HOST_NAME") : "localhost";
configurable string username = isTestOnLiveServer ? os:getEnv("USERNAME") : "admin";
configurable string password = isTestOnLiveServer ? os:getEnv("PASSWORD") : "admin";

boolean isBalBuild = os:getEnv("IS_BAL_BUILD") == "true";
string certPathPostFix = isBalBuild ? "../" : "/home/ballerina/ballerina/";

Client s4HanaClient = test:mock(Client);

@test:BeforeSuite
function initializeClientsForS4HanaServer() returns error? {
    if isTestOnLiveServer {
        log:printInfo("Running tests on S4HANA server");
        s4HanaClient = check new (
            {
                auth: {
                    username,
                    password
                }
            },
            hostname
        );
    } else {
        log:printInfo("Running tests on mock server");
        s4HanaClient = check new (
            {
                auth: {
                    username,
                    password
                },
                secureSocket: {
                    cert: certPathPostFix + "resources/public.crt"
                }
            },
            hostname,
            9090
        );
    }
}

@test:Config {
}
function testListQualityFirstArticleInspections() returns error? {
    CollectionOfQualityFirstArticleInspectionWrapper listQltyFirstArticleInspections = check s4HanaClient->listQualityFirstArticleInspections({});
    test:assertTrue(listQltyFirstArticleInspections.d?.results !is (), "The quality info record is expected to be non-empty.");
}

//Since creating a quality info record needs master data. This create response is meant to fail.
@test:Config {
}
function testCreateQltyFirstArticleInspOfQualityInProcurement() returns error? {
    QualityFirstArticleInspectionWrapper|error creatingQltyFirstArticleInspOfQltyInProc = s4HanaClient->createQualityFirstArticleInspection({
        QltyInProcmtIntID: "000001",
        QltyInProcmt1stArticleInsp: "",
        Material: "585"
    });
    test:assertTrue(creatingQltyFirstArticleInspOfQltyInProc is error, "The quality info record response expected to be 500");
    error e = <error>creatingQltyFirstArticleInspOfQltyInProc;
    test:assertEquals(e.detail()["statusCode"], 500, "Expected 500 status code");
}
