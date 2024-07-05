# Read S/4HANA Master Inspection data and sync a MySQL database

This example demonstrates how to use Ballerina to interact with the `sap.s4hana.api_masterinspcharacteristic_srv:Client` for accessing S/4HANA Quality Management module, and then syncing a MySQL database based on this information.

The example works as follows:

![example workflow](..\SAP-to-Database\SAPtoDBworkflow.png)
 
## Prerequisites

### 1. Setup the S/4HANA API

Refer to the [Setup Guide](https://central.ballerina.io/ballerinax/sap/latest#setup-guide) for obtaining necessary credentials (
hostname, username, password) to acess the S/4HANA API.

### 2. Setup a database server
Set up a MySQL database using your preferred client. Create the following table schema:

```sql
USE database_name;

CREATE TABLE Ins_Spec_Directory (
    InspectionSpecification VARCHAR(8),
    InspectionSpecVersion VARCHAR(6),
    InspectionSpecPlant VARCHAR(4),
    Plant VARCHAR(50),
    ValidityStartDate VARCHAR(15),
    InspectionSpecSrchTxt VARCHAR(60),
    InspSpecGlobalName VARCHAR(60),
    InspSpecChangeDate VARCHAR(15),
    PRIMARY KEY (InspectionSpecification, InspectionSpecVersion, InspectionSpecPlant)
);
```

### 2. Configuration

In the example directory, create a `Config.toml` file to configure the database credentials and S/4HANA API. Add your credentials there:

```toml
[s4hanaClientConfig]
hostname = "<Hostname>"
username = "<Username>"
password = "<Password>"

[databaseConfig]
host = "<MySQL host>"
username = "<MySQL username>"
password = "<MySQL password>"
databaseName = "<MySQL databaseName>"
port = "<MySQL port>"
```

## Run the Example

Execute the following command to run the example:

```bash
bal run
```
