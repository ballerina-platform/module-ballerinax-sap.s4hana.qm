# Examples

The S/4 HANA Quality Management Ballerina connectors provide practical examples illustrating usage in various
scenarios. Explore
these [examples](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/tree/main/examples), covering
use cases like accessing S/4HANA Master Inspection Characteristic - Read API or Inspection Lot API.

1. [S/4HANA to Database Integration](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/tree/main/examples/SAP-to-Database) -
   This example demonstrates how to use Ballerina to interact with the `sap.s4hana.api_masterinspcharacteristic_srv:Client` for accessing S/4HANA Quality Management module data, and then updating a MySQL database based on this information.

2. [Paper invoice to S/4HANA](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/tree/main/examples/paper-invoice-to-inspectionlot) -
   demonstrates how to use Ballerina's `sap.s4hana.api_inspectionlot_srv:Client` for S/4HANA API interactions. Optical character recognition (OCR) with [Eden AI](edenai.co) API is used to extract data from a physical invoice. The data is then used to establish an inspection lot to initiate the inspection process in the S/4HANA QM module.


## Prerequisites

Each example includes detailed steps.

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the Examples with the Local Module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the
module is manually written to the central repository as a workaround. Consequently, the bash script may modify your
local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```