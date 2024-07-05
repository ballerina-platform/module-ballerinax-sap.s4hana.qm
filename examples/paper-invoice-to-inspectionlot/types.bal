type ExtractedInvoice record {
    record {
        PaperInvoice[] extracted_data;
    } eden\-ai;
};

type PaperInvoice record {
    string invoice_number;
    string date;
    record {string merchant_name;} merchant_information;
    InvoiceItem[] item_lines;
};

type InvoiceItem record {
    string description;
    int quantity;
};

type SAPInspectionLot record {
    string InspectionLot;
    string InspectionLotType;
    InspectionLot[] _InspectionLotDetails;
};

type InspectionLot record {
    string Material;
    string Plant;
    int Quantity;
};

type S4HANAClientConfig record {|
    string hostname;
    string username;
    string password;
|};
