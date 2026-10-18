# Ballerina SAP S/4HANA Quality Management Connectors

[![Build](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-sap.s4hana.qm.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/s4hana.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fs4hana)

[SAP S/4HANA](https://www.sap.com/products/erp/s4hana.html) is a robust enterprise resource planning (ERP) solution,
designed for large-scale enterprises by SAP SE. It covers core business processes such as finance, procurement, sales,
and materials management, including quality management.

This repository encompasses all Ballerina packages pertaining to the SAP S/4HANA Quality Management module. Notably:

1. [SAP S/4HANA Inspection Lot](ballerina/api_inspectionlot_srv) provides a way to interact with the
   [Inspection Lot API](https://api.sap.com/api/API_INSPECTIONLOT_SRV/overview).
   The service allows to read and update inspection lots with their operations, characteristics, subsets and serial
   numbers, record inspection results and sample results, and create usage decisions.

2. [SAP S/4HANA Inspection Plan](ballerina/api_inspectionplan_srv) provides a way to interact with the
   [Inspection Plan API](https://api.sap.com/api/API_INSPECTIONPLAN_SRV/overview).
   The service allows to create, read, update and delete inspection plans, with their material assignments,
   operations, inspection characteristics, dependent characteristics and production resources and tools.

3. [SAP S/4HANA Master Inspection Characteristic](ballerina/api_masterinspcharacteristic_srv) provides a way to interact with the
   [Master Inspection Characteristic - Read API](https://api.sap.com/api/API_MASTERINSPCHARACTERISTIC_SRV/overview).
   The service allows to read master inspection characteristics, the master data records that describe the quality
   inspection criteria for materials, with their settings, control indicators and texts.

4. [SAP S/4HANA Inspection Method](ballerina/api_inspectionmethod_srv) provides a way to interact with the
   [Inspection Method - Read API](https://api.sap.com/api/API_INSPECTIONMETHOD_SRV/overview).
   The service allows to read inspection methods, the master data records that describe the procedure for performing
   the quality inspection of a characteristic, with their settings, administrative data and texts.

5. [SAP S/4HANA Quality Info Record](ballerina/api_qualityinforecord_srv) provides a way to interact with the
   [Quality Info Record API](https://api.sap.com/api/API_QUALITYINFORECORD_SRV/overview).
   The service allows to create, read, update and delete quality info records in procurement and the related first
   article inspections.

6. [SAP S/4HANA Characteristic Attribute Catalog](ballerina/api_charcattributecatalog_srv) provides a way to interact with the
   [Characteristic Attribute Catalog - Read API](https://api.sap.com/api/API_CHARCATTRIBUTECATALOG_SRV/overview).
   The service allows to read the plant-specific selected sets of a characteristic attribute catalog, with their
   codes and texts, that are used to record inspection results for qualitative characteristics, for example, the
   codes 01 (Smooth) and 02 (Rough) for the characteristic Surface.

## Issues and projects

The **Issues** and **Projects** tabs are disabled for this repository as this is part of the Ballerina library. To
report bugs, request new features, start new discussions, view project boards, etc., visit the Ballerina
library [parent repository](https://github.com/ballerina-platform/ballerina-library).

This repository only contains the source code for the package.

## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following
   sources:

   * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
   * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was
   installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

### Build options

Execute the commands below to build from the source.

1. To build all packages:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests in all packages:

   ```bash
   ./gradlew clean test
   ```

3. To build without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To build only one specific package:

   ```bash
   ./gradlew clean :qm-ballerina:<module_name>:build
   ```

   | Module Name                      | Connector                                              |
   |----------------------------------|--------------------------------------------------------|
   | api_inspectionlot_srv            | ballerinax/sap.s4hana.api_inspectionlot_srv            |
   | api_inspectionplan_srv           | ballerinax/sap.s4hana.api_inspectionplan_srv           |
   | api_masterinspcharacteristic_srv | ballerinax/sap.s4hana.api_masterinspcharacteristic_srv |
   | api_inspectionmethod_srv         | ballerinax/sap.s4hana.api_inspectionmethod_srv         |
   | api_qualityinforecord_srv        | ballerinax/sap.s4hana.api_qualityinforecord_srv        |
   | api_charcattributecatalog_srv    | ballerinax/sap.s4hana.api_charcattributecatalog_srv    |

5. To run tests against a live server, add a `tests/Config.toml` file to the package with the live server details
   and run the tests (`Config.toml` files are ignored by Git):

   ```toml
   isTestOnLiveServer = true
   hostname = "<unique id>-api.s4hana.cloud.sap"
   username = "<communication user>"
   password = "<password>"
   ```

   **Note**: Tests are run against the mock server by default.

6. To debug packages with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

7. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

8. Publish the generated artifacts to the local Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToLocalCentral=true
   ```

9. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`sap` package](https://lib.ballerina.io/ballerinax/sap/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
