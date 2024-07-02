// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

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

import ballerina/http;
import ballerinax/sap;

# 

# 

# The data related to a quality info record and first article inspection has one entity type each. For read operations, filter information must be sent according to the OData protocol. All filter information is utilized when retrieving quality info records or data related to first article inspection. The detailed entity data is sent in the response. If any issues arise when quality info records or data related to first article inspection is retrieved, the system displays error messages in the response.

public isolated client class Client {
    final sap:Client clientEp;

    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string hostname, int port = 443) returns error? {
        string serviceUrl = string `https://${hostname}:${port}/sap/opu/odata/sap/API_QUALITYINFORECORD_SRV`;
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        sap:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }

    # Add new entity to related to_QltyFirstArticleInsp
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + headers - Headers to be sent with the request 
    # + payload - New entity 
    # + return - Created entity 
    remote isolated function createQltyFirstArticleInspOfQualityInProcurement(string Material, string QltyInProcmtIntID, CreateQualityFirstArticleInspection payload, map<string|string[]> headers = {}) returns QualityFirstArticleInspectionWrapper|error {
        string resourcePath = string `/QualityInProcurement(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}')/to_QltyFirstArticleInsp`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Add new entity to QualityFirstArticleInspection
    #
    # + headers - Headers to be sent with the request 
    # + payload - New entity 
    # + return - Created entity 
    remote isolated function createQualityFirstArticleInspection(CreateQualityFirstArticleInspection payload, map<string|string[]> headers = {}) returns QualityFirstArticleInspectionWrapper|error {
        string resourcePath = string `/QualityFirstArticleInspection`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Add new entity to QualityInProcurement
    #
    # + headers - Headers to be sent with the request 
    # + payload - New entity 
    # + return - Created entity 
    remote isolated function createQualityInProcurement(CreateQualityInProcurement payload, map<string|string[]> headers = {}) returns QualityInProcurementWrapper|error {
        string resourcePath = string `/QualityInProcurement`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Delete entity from QualityFirstArticleInspection
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + QltyInProcmt1stArticleInsp - First Article Inspection Number in Quality Info Record
    # + headers - Headers to be sent with the request 
    # + return - Success 
    remote isolated function deleteQualityFirstArticleInspection(string Material, string QltyInProcmtIntID, string QltyInProcmt1stArticleInsp, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/QualityFirstArticleInspection(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}',QltyInProcmt1stArticleInsp='${getEncodedUri(QltyInProcmt1stArticleInsp)}')`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Delete entity from QualityInProcurement
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + headers - Headers to be sent with the request 
    # + return - Success 
    remote isolated function deleteQualityInProcurement(string Material, string QltyInProcmtIntID, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/QualityInProcurement(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}')`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get related to_QltyInProcurement
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + QltyInProcmt1stArticleInsp - First Article Inspection Number in Quality Info Record
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Retrieved entity 
    remote isolated function getQltyInProcurementOfQualityFirstArticleInspection(string Material, string QltyInProcmtIntID, string QltyInProcmt1stArticleInsp, map<string|string[]> headers = {}, *GetQltyInProcurementOfQualityFirstArticleInspectionQueries queries) returns QualityInProcurementWrapper|error {
        string resourcePath = string `/QualityFirstArticleInspection(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}',QltyInProcmt1stArticleInsp='${getEncodedUri(QltyInProcmt1stArticleInsp)}')/to_QltyInProcurement`;
        map<Encoding> queryParamEncoding = {"$select": {style: FORM, explode: false}, "$expand": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get entity from QualityFirstArticleInspection by key
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + QltyInProcmt1stArticleInsp - First Article Inspection Number in Quality Info Record
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Retrieved entity 
    remote isolated function getQualityFirstArticleInspection(string Material, string QltyInProcmtIntID, string QltyInProcmt1stArticleInsp, map<string|string[]> headers = {}, *GetQualityFirstArticleInspectionQueries queries) returns QualityFirstArticleInspectionWrapper|error {
        string resourcePath = string `/QualityFirstArticleInspection(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}',QltyInProcmt1stArticleInsp='${getEncodedUri(QltyInProcmt1stArticleInsp)}')`;
        map<Encoding> queryParamEncoding = {"$select": {style: FORM, explode: false}, "$expand": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get entity from QualityInProcurement by key
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Retrieved entity 
    remote isolated function getQualityInProcurement(string Material, string QltyInProcmtIntID, map<string|string[]> headers = {}, *GetQualityInProcurementQueries queries) returns QualityInProcurementWrapper|error {
        string resourcePath = string `/QualityInProcurement(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}')`;
        map<Encoding> queryParamEncoding = {"$select": {style: FORM, explode: false}, "$expand": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get entities from related to_QltyFirstArticleInsp
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Retrieved entities 
    remote isolated function listQltyFirstArticleInspsOfQualityInProcurement(string Material, string QltyInProcmtIntID, map<string|string[]> headers = {}, *ListQltyFirstArticleInspsOfQualityInProcurementQueries queries) returns CollectionOfQualityFirstArticleInspectionWrapper|error {
        string resourcePath = string `/QualityInProcurement(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}')/to_QltyFirstArticleInsp`;
        map<Encoding> queryParamEncoding = {"$orderby": {style: FORM, explode: false}, "$select": {style: FORM, explode: false}, "$expand": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get entities from QualityFirstArticleInspection
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Retrieved entities 
    remote isolated function listQualityFirstArticleInspections(map<string|string[]> headers = {}, *ListQualityFirstArticleInspectionsQueries queries) returns CollectionOfQualityFirstArticleInspectionWrapper|error {
        string resourcePath = string `/QualityFirstArticleInspection`;
        map<Encoding> queryParamEncoding = {"$orderby": {style: FORM, explode: false}, "$select": {style: FORM, explode: false}, "$expand": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Get entities from QualityInProcurement
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Retrieved entities 
    remote isolated function listQualityInProcurements(map<string|string[]> headers = {}, *ListQualityInProcurementsQueries queries) returns CollectionOfQualityInProcurementWrapper|error {
        string resourcePath = string `/QualityInProcurement`;
        map<Encoding> queryParamEncoding = {"$orderby": {style: FORM, explode: false}, "$select": {style: FORM, explode: false}, "$expand": {style: FORM, explode: false}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        return self.clientEp->get(resourcePath, headers);
    }

    # Update entity in QualityFirstArticleInspection
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + QltyInProcmt1stArticleInsp - First Article Inspection Number in Quality Info Record
    # + headers - Headers to be sent with the request 
    # + payload - New property values 
    # + return - Success 
    remote isolated function patchQualityFirstArticleInspection(string Material, string QltyInProcmtIntID, string QltyInProcmt1stArticleInsp, Modified\ QualityFirstArticleInspectionType payload, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/QualityFirstArticleInspection(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}',QltyInProcmt1stArticleInsp='${getEncodedUri(QltyInProcmt1stArticleInsp)}')`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Update entity in QualityInProcurement
    #
    # + Material - Material Number
    # + QltyInProcmtIntID - Quality Info Record in Procurement Internal ID
    # + headers - Headers to be sent with the request 
    # + payload - New property values 
    # + return - Success 
    remote isolated function patchQualityInProcurement(string Material, string QltyInProcmtIntID, Modified\ QualityInProcurementType payload, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/QualityInProcurement(Material='${getEncodedUri(Material)}',QltyInProcmtIntID='${getEncodedUri(QltyInProcmtIntID)}')`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, headers);
    }

    # Send a group of requests
    #
    # + headers - Headers to be sent with the request 
    # + request - Batch request 
    # + return - Batch response 
    remote isolated function performBatchOperation(http:Request request, map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/$batch`;
        // TODO: Update the request as needed;
        return self.clientEp->post(resourcePath, request, headers);
    }
}
