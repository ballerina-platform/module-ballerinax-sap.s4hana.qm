import ballerina/constraint;

type S4HANAClientConfig record {|
    string hostname;
    string username;
    string password;
|};

type DatabaseConfig record {|
    string host;
    string username;
    string password;
    string databaseName;
    int port;
|};

type InspectionSpecificationRec record {
    @constraint:String {maxLength: 8}
    string InspectionSpecification?;
    @constraint:String {maxLength: 6}
    string InspectionSpecificationVersion?;
    @constraint:String {maxLength: 4}
    string InspectionSpecificationPlant?;
    string? Plant?;
    string? ValidityStartDate?;
    string? InspectionSpecificationSrchTxt?;
    string? InspSpecGlobalName?;
    string? InspSpecChangeDate?;
};

type InspectionSpecificationKey record {
    @constraint:String {maxLength: 8}
    string InspectionSpecification;
};
