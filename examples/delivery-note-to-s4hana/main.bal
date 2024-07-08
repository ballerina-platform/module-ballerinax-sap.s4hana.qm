// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.org).
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
import ballerina/log;
import ballerina/mime;
import ballerina/uuid;
import ballerinax/sap.s4hana.api_inspectionlot_srv as inspectionLot;

configurable S4HANAClientConfig s4hanaClientConfig = ?;
configurable string ocrToken = ?;
configurable string invoiceUrl = "https://www.clearspider.com/wp-content/uploads/2017/09/Capture.png";

const OCR_REQUEST_PATH = "/invoice_parser";
const OCR_URL = "https://api.edenai.run/v2/ocr";

const map<string> & readonly materialMap = {"Material A": "FG376", "Material B": "2020"};
const map<string> & readonly inspectionLotPerMaterial = {"FG376": "89FG", "2020": "89QM"};

final http:Client ocrHttpClient = check new (
    url = OCR_URL,
    auth = {token: ocrToken},
    cookieConfig = {enabled: true}
);

final inspectionLot:Client inspectionLotClient = check new (
    config = {
        auth: {
            username: s4hanaClientConfig.username,
            password: s4hanaClientConfig.password
        }
    },
    hostname = s4hanaClientConfig.hostname
);

public function main() {

    PaperDeliveryNote|error paperNote = readPaperDeliveryNote();
    if paperNote is error {
        log:printError(string `Error while reading paper invoice: ${paperNote.message()}`);
        return;
    }

    inspectionLot:CreateA_InspectionLot[] inspectionLots = from InvoiceItem item in paperNote.item_lines
        let string inspectionLot = uuid:createRandomUuid().substring(0, 10)
        let string materialId = materialMap.get("Material A")
        select {
            InspectionLot: inspectionLot,
            InspectionLotType: inspectionLotPerMaterial.get(materialId),
            Material: materialId,
            Plant: "1010",
            InspectionLotQuantity: item.quantity.toString()
        };

    foreach inspectionLot:CreateA_InspectionLot inspectionLotData in inspectionLots {
        inspectionLot:A_InspectionLotWrapper|error inspectionLotResponse = inspectionLotClient->createA_InspectionLot(inspectionLotData);
        if inspectionLotResponse is error {
            log:printError(string `Error while creating SAP Inspection Lot for material: ${inspectionLotData?.Material ?: ""}. ${inspectionLotResponse.message()}`);
            continue;
        }
        log:printInfo(string `Inspection lot with number ${paperNote.invoice_number} for material ${inspectionLotData?.Material ?: ""} is created.`);
    }
}

isolated function readPaperDeliveryNote() returns PaperDeliveryNote|error {
    ExtractedInvoice|http:Error response = ocrHttpClient->post(
        path = OCR_REQUEST_PATH,
        message = {
        show_original_response: "false",
        fallback_providers: "",
        providers: "google",
        language: "en",
        file_url: invoiceUrl
    },
        headers = {[http:CONTENT_TYPE]: mime:APPLICATION_JSON},
        targetType = ExtractedInvoice
    );
    if response is http:Error {
        return response;
    }
    return response.eden\-ai.extracted_data[0];
}
