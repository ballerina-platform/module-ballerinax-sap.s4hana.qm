import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/sap.s4hana.api_masterinspcharacteristic_srv as mastinpchar;
import ballerina/log;

configurable S4HANAClientConfig s4hanaClientConfig = ?;
configurable DatabaseConfig databaseConfig = ?;

final mastinpchar:Client mastinpcharClient = check new (
    config = {
        auth: {
            username: s4hanaClientConfig.username,
            password: s4hanaClientConfig.password
        }
    },
    hostname = s4hanaClientConfig.hostname
);


final mysql:Client companyDatabase = check new (
    databaseConfig.host,
    databaseConfig.username,
    databaseConfig.password,
    databaseConfig.databaseName,
    databaseConfig.port
);

public function main() returns error? {
    mastinpchar:CollectionOfA_InspectionSpecificationWrapper collectionOfInspectionSpecs = check mastinpcharClient->listA_InspectionSpecifications();
    mastinpchar:A_InspectionSpecification[] specsFromSAP = collectionOfInspectionSpecs.d?.results ?: [];
    sql:ParameterizedQuery searchQuery = `SELECT InspectionSpecification FROM Ins_Spec_Directory`;
    stream<InspectionSpecificationKey,error?> resultFromDB = companyDatabase-> query(searchQuery);
    string[] specificationsInDB = check from InspectionSpecificationKey key in resultFromDB 
                                                      select key.InspectionSpecification;
    InspectionSpecificationRec[] specsNotinDB = [];
    foreach mastinpchar:A_InspectionSpecification specItem in specsFromSAP{
        string inspectionSpec = specItem.InspectionSpecification ?: "";
        if specificationsInDB.indexOf(inspectionSpec) == (){
            specsNotinDB.push(specItem);
        }        
    }
    if specsNotinDB != []{
        sql:ExecutionResult[]|error insertResult = check insertSpecification(specsNotinDB);
        if insertResult is error{
            log:printError(insertResult.toString());
        }
        else{
            log:printInfo(insertResult.toString());
        }
    }
    else {
        log:printInfo("Database is upto date.");
    }
}
