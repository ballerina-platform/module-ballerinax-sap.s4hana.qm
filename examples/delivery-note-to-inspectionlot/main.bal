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
import ballerinax/sap.s4hana.api_inspectionlot_srv as inspectionLot;

const OCR_REQUEST_PATH = "/invoice_parser";
const OCR_URL = "https://api.edenai.run/v2/ocr";
const CONTENT_TYPE = "Content-Type";
const APPLICATION_JSON = "application/json";

configurable S4HANAClientConfig s4hanaClientConfig = ?;
configurable string ocrToken = ?;
configurable string invoiceUrl = ?;

const map<string> & readonly supplierMap = {"SNG Engineering Inc": "1010"};
const map<string> & readonly plantMap = {"SNG Engineering Inc": "1010"};
const map<string> & readonly materialMap = {"89FG": "FG376", "89QM": "E002"};

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

    PaperInvoice|error invoiceResponse = readPaperInvoice();
    if invoiceResponse is error {
        log:printError("Error while reading paper invoice: " + invoiceResponse.message());
        return;
    }
    log:printInfo("Received inspection lot with invoice number: " + invoiceResponse.invoice_number + " on " + invoiceResponse.date);

    inspectionLot:CreateA_InspectionLot|error inspectionLotData = transformInspectionLotData(invoiceResponse);
    if inspectionLotData is error {
        log:printError("Error while transforming inspection lot: " + inspectionLotData.message());
        return;
    }

    inspectionLot:A_InspectionLotWrapper|error inspectionLotResponse = inspectionLotClient->createA_InspectionLot(inspectionLotData);
    if inspectionLotResponse is error {
        log:printError("Error while creating SAP Inspection Lot: " + inspectionLotResponse.message());
    } else {
        log:printInfo("Inspection lot with invoice number: " + invoiceResponse.invoice_number + " is created");
    }
}

isolated function readPaperInvoice() returns PaperInvoice|error {
    ExtractedInvoice|http:Error response = ocrHttpClient->post(
        path = OCR_REQUEST_PATH,
        message = {
        show_original_response: "false",
        fallback_providers: "",
        providers: "google",
        language: "en",
        file_url: invoiceUrl
    },
        headers = {[CONTENT_TYPE]: APPLICATION_JSON},
        targetType = ExtractedInvoice
    );
    if response is http:Error {
        return response;
    }
    return response.eden\-ai.extracted_data[0];
}

isolated function transformInspectionLotData(PaperInvoice paperInvoice) returns inspectionLot:CreateA_InspectionLot|error {
    string inspectionLot = "890000038513";
    string inspectionLotType = "89FG";
    string supplier = paperInvoice.merchant_information.merchant_name;
    string plant = plantMap.get(supplier);
    string material = materialMap.get(inspectionLotType);

    InspectionLot[] inspectionLotDetails = from InvoiceItem lineItem in paperInvoice.item_lines
        select
        {
            Material: material,
            Plant: plant,
            Quantity: lineItem.quantity
        };

    return {
        InspectionLot: inspectionLot,
        InspectionLotType: inspectionLotType,
        Material: inspectionLotDetails[0].Material,
        Plant: inspectionLotDetails[0].Plant,
        InspectionLotQuantity: inspectionLotDetails[0].Quantity.toString()
    };
}
