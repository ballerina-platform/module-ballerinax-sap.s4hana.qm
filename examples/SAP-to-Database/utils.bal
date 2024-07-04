import ballerina/sql;

isolated function insertSpecification(InspectionSpecificationRec[] recordsToAdd) returns sql:ExecutionResult[]|error {
    sql:ParameterizedQuery[] insertQueries = from InspectionSpecificationRec spec in recordsToAdd
        select `INSERT INTO Ins_Spec_Directory(InspectionSpecification,
                                                InspectionSpecificationVersion,
                                                InspectionSpecificationPlant,
                                                Plant,ValidityStartDate,
                                                InspectionSpecificationSrchTxt,
                                                InspSpecGlobalName,
                                                InspSpecChangeDate)
                  values(${spec.InspectionSpecification},
                          ${spec.InspectionSpecificationVersion},
                          ${spec.InspectionSpecificationPlant},
                          ${spec?.Plant},
                          ${spec?.ValidityStartDate},
                          ${spec?.InspectionSpecificationSrchTxt},
                          ${spec?.InspSpecGlobalName},
                          ${spec?.InspSpecChangeDate})`;
    sql:ExecutionResult[]|error insertResult = companyDatabase->batchExecute(insertQueries);
    return insertResult;
}
