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

import ballerina/log;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/sap.s4hana.api_masterinspcharacteristic_srv as masterdata;

configurable S4HANAClientConfig s4hanaClientConfig = ?;
configurable DatabaseConfig databaseConfig = ?;

final masterdata:Client masterdataClient = check new (
    config = {
        auth: {
            username: s4hanaClientConfig.username,
            password: s4hanaClientConfig.password
        }
    },
    hostname = s4hanaClientConfig.hostname
);

final mysql:Client db = check new (
    databaseConfig.host,
    databaseConfig.username,
    databaseConfig.password,
    databaseConfig.databaseName,
    databaseConfig.port
);

public function main() returns error? {

    masterdata:CollectionOfA_InspectionSpecificationWrapper response =
                    check masterdataClient->listA_InspectionSpecifications();
    masterdata:A_InspectionSpecification[] inspectionSpecifications = response.d?.results ?: [];

    stream<record {string id;}, error?> resultFromDB =
                                        db->query(`SELECT InspectionSpecification AS id FROM Ins_Spec_Directory`);
    string[] specificationIds = check from record {string id;} key in resultFromDB
        select key.id;

    masterdata:A_InspectionSpecification[] specsNotinDB = inspectionSpecifications.filter(
        (value) => specificationIds.indexOf(value.InspectionSpecification ?: "") is ()
        );

    if specsNotinDB == [] {
        log:printInfo("Database is upto date.");
        return;
    }

    sql:ParameterizedQuery[] insertQueries = from masterdata:A_InspectionSpecification spec in specsNotinDB
        select `INSERT INTO Ins_Spec_Directory(InspectionSpecification,
                                                InspectionSpecVersion,
                                                InspectionSpecPlant,
                                                Plant,ValidityStartDate,
                                                InspectionSpecSrchTxt,
                                                InspSpecGlobalName,
                                                InspSpecChangeDate)
                  values(${spec?.InspectionSpecification},
                          ${spec?.InspectionSpecificationVersion},
                          ${spec?.InspectionSpecificationPlant},
                          ${spec?.Plant},
                          ${spec?.ValidityStartDate},
                          ${spec?.InspectionSpecificationSrchTxt},
                          ${spec?.InspSpecGlobalName},
                          ${spec?.InspSpecChangeDate})`;

    sql:ExecutionResult[]|sql:Error insertResult = db->batchExecute(insertQueries);
    if insertResult is sql:BatchExecuteError {
        int[] errorIndexes = from sql:ExecutionResult result in insertResult.detail().executionResults
            where result.affectedRowCount == sql:EXECUTION_FAILED
            select <int>insertResult.detail().executionResults.indexOf(result);
        log:printError("Following results failed to be updated in database:");
        foreach int index in errorIndexes {
            log:printInfo(specsNotinDB[index].InspectionSpecification ?: "");
        }
        return;
    }

    if insertResult is sql:Error {
        log:printError("Error occurred while inserting data to database." + insertResult.message());
        return;
    }

    log:printInfo("Database Insertion succsessful. Inserted records: ");
    specificationIds.forEach((id) => log:printInfo(id));
}
