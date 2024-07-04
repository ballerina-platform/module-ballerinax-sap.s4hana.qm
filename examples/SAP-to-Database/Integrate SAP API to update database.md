# Read SAP Inspection Master data and Update your mySQL database

This example illustrates leveraging the `sap.s4hana.api_masterinspcharacteristic_srv:Client` in Ballerina for S/4HANA API interactions. It specifically showcases how to get master data from S/4HANA Quality Management module and check your own database to see if the data should be inserted or not.

The example works as follows:

![example workflow](SAPtoDBexampleworkflow.png)
 
## Prerequisites

### 1. Setup the S/4HANA API

Refer to the [Setup Guide](https://central.ballerina.io/ballerinax/sap/latest#setup-guide) for necessary credentials (
hostname, username, password).

### 2. Setup a database server

Setup a database server using your prefered mySQL client. The table creation should be as follows:

```sql
USE database_name;

CREATE TABLE Ins_Spec_Directory (
    InspectionSpecification VARCHAR(8),
    InspectionSpecificationVersion VARCHAR(6),
    InspectionSpecificationPlant VARCHAR(4),
    Plant VARCHAR(50),
    ValidityStartDate VARCHAR(15),
    InspectionSpecificationSrchTxt VARCHAR(60),
    InspSpecGlobalName VARCHAR(60),
    InspSpecChangeDate VARCHAR(15),
    PRIMARY KEY (InspectionSpecification, InspectionSpecificationVersion, InspectionSpecificationPlant)
);
```

### 2. Setup a Client to the database

The basic setup for the client is already written in the example. Refer to the [mySQL package](https://central.ballerina.io/ballerinax/mysql/latest) to learn more.

### 3. Configuration

Configure S/4HANA API and database credentials in `Config.toml` in the example directory:

```toml
[s4hanaClientConfig]
hostname = "<Hostname>"
username = "<Username>"
password = "<Password>"

[databaseConfig]
host = "<host>"
username = "<username>"
password = "<password>"
databaseName = "<databaseName>"
port = "<port>"
```

## Run the Example

Execute the following command to run the example:

```bash
bal run
```
