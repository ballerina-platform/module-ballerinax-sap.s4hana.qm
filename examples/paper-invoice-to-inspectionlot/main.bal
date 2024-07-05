import ballerina/http;
import ballerina/log;
import ballerinax/sap.s4hana.api_inspectionlot_srv as inspectionLot;
import ballerina/io;

const OCR_REQUEST_PATH = "/invoice_parser";
const OCR_URL = "https://api.edenai.run/v2/ocr";
const CONTENT_TYPE = "Content-Type";
const APPLICATION_JSON = "application/json";

configurable S4HANAClientConfig s4hanaClientConfig = ?;
configurable string ocrToken = ?;
configurable string invoiceUrl = ?;

final map<string> & readonly supplierMap = {"SNG Engineering Inc": "1010"};
final map<string> & readonly plantMap = {"SNG Engineering Inc": "1010"};
final map<string> & readonly materialMap = {"89FG": "FG376", "89QM": "E002"};

final http:Client ocrHttpClient = check getOCRHttpClient();

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
    SAPInspectionLot|error inspectionLotData = transformInspectionLotData(invoiceResponse);
    if inspectionLotData is error {
        log:printError("Error while transforming inspection lot: " + inspectionLotData.message());
        return;
    }
    io:print(inspectionLotData);

    InspectionLot[] data = inspectionLotData._InspectionLotDetails;
    inspectionLot:CreateA_InspectionLot inspectionLot = {
        InspectionLot: inspectionLotData.InspectionLot,
        InspectionLotType: inspectionLotData.InspectionLotType,
        Material: data[0].Material,
        Plant: data[0].Plant,
        InspectionLotQuantity: data[0].Quantity.toString()
    };

    inspectionLot:A_InspectionLotWrapper|error inspectionLotResponse = inspectionLotClient->createA_InspectionLot(inspectionLot);
    if inspectionLotResponse is error {
        log:printError("Error while creating SAP Inspection Lot: " + inspectionLotResponse.message());
    }
     io:println(inspectionLotResponse);
}

isolated function getOCRHttpClient() returns http:Client|error {
    http:BearerTokenConfig tokenAuthHandler = {token: ocrToken};
    return new (url = OCR_URL, auth = tokenAuthHandler, cookieConfig = {enabled: true});
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
        headers = {[CONTENT_TYPE] : APPLICATION_JSON},
        targetType = ExtractedInvoice
    );
    if response is http:Error {
        return response;
    }
    return response.eden\-ai.extracted_data[0];
}

isolated function transformInspectionLotData(PaperInvoice paperInvoice) returns SAPInspectionLot|error {
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
            Quantity:lineItem.quantity
        };
    return {
        InspectionLot: inspectionLot,
        InspectionLotType:inspectionLotType,
        _InspectionLotDetails: inspectionLotDetails
    };
}
