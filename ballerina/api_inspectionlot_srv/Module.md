## Overview

[S/4HANA](https://www.sap.com/india/products/erp/s4hana.html) is a robust enterprise resource planning (ERP) solution,
designed for large-scale enterprises by SAP SE.

The `ballerinax/sap.s4hana.api_inspectionlot_srv` package offers APIs for seamless integration with the [Inspection Lot API v1.2.0](https://api.sap.com/api/API_INSPECTIONLOT_SRV/overview).In the SAP system, you process quality inspections on the basis of inspection lots. With this service it is possible, for example, to update inspection lot header data or to create inspection results and usage decisions.

## Setup guide

1. Sign in to your S/4HANA dashboard.

2. Under the `Communication Management` section, click on the `Display Communications Scenario` title.

   ![Display Scenarios](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-sap/main/docs/setup/3-1-display-scenarios.png)

3. In the search bar, type `Quality Inspection Process Integration` and select the corresponding scenario from the results.

   ![Search Sales Order](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-sap/main/docs/setup/3-2-search-sales-order.png)

4. In the top right corner of the screen, click on `Create Communication Arrangement`.

   ![Click Create Arrangement](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-sap/main/docs/setup/3-3-click-create-arrangement.png)

5. Enter a unique name for the arrangement.

   ![Give Arrangement Name](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-sap/main/docs/setup/3-4-give-arrangement-name.png)

6. Choose an existing `Communication System` from the dropdown menu and save your arrangement.

   ![Select Existing Communication Arrangement](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-sap/main/docs/setup/3-5-select-communication-system.png)

7. The hostname (`<unique id>-api.s4hana.cloud.sap`) will be displayed in the top right corner of the screen.

   ![View Hostname](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-sap/main/docs/setup/3-6-view-hostname.png)

## Quickstart

To use the `sap.s4hana.api_inspectionlot_srv` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the module

Import the `sap.s4hana.api_inspectionlot_srv` module.

```ballerina
import ballerinax/sap.s4hana.api_inspectionlot_srv as inspectionlot;
```

### Step 2: Instantiate a new connector

Use the hostname and credentials to initiate a client

```ballerina
configurable string hostname = ?;
configurable string username = ?;
configurable string password = ?;

inspectionlot:Client inspectionlotClient = check new (
    {
        auth: {
            username,
            password
        }
    },
    hostname
);
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

```ballerina
inspectionlot:CollectionOfA_InspectionLotWrapper listOfInspectionlots = check inspectionlotClient->listA_Inspectionlots();
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The S/4HANA Quality Management Ballerina connectors provide practical examples illustrating usage in various
scenarios. Explore
these [examples](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/tree/main/examples), covering
use cases S/4HANA to database, paper delivery note to S/4HANA integrations.

1. [S/4HANA to Database Integration](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/tree/main/examples/SAP-to-Database) -
   This example demonstrates how to use Ballerina to interact with
   the `sap.s4hana.api_masterinspcharacteristic_srv:Client` for accessing S/4HANA Quality Management module, and then
   syncing a MySQL database based on this information.

2. [Paper Delivery Note to S/4HANA](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/tree/main/examples/delivery-note-to-s4hana) -
   Demonstrates how to use Ballerina's `sap.s4hana.api_inspectionlot_srv:Client` to interact with S/4HANA API. Optical
   character recognition (OCR) with [Eden AI](https://www.edenai.co/) API is used to extract data from a physical delivery note. The
   data is then used to establish an inspection lot to initiate the inspection process in the S/4HANA QM module.
