# Ballerina S/4HANA Quality Management Connectors

[![Build](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/ballerina-platform/module-ballerinax-sap.s4hana.qm/branch/main/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerinax-sap.s4hana.qm)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-sap.s4hana.qm.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.s4hana.qm/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/s4hana.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fs4hana)

[S/4HANA](https://www.sap.com/india/products/erp/s4hana.html) is a robust enterprise resource planning (ERP) solution,
designed for large-scale enterprises by SAP SE.

This repository encompasses all Ballerina packages pertaining to the S/4HANA Quality Management submodule. Notably:

1. The `ballerinax/sap.s4hana.api_inspectionlot_srv` package provides APIs that enable seamless integration with
   the [Inspection Lot API v1.2.0](https://api.sap.com/api/API_INSPECTIONLOT_SRV/overview). This service enables you to read, create, and update inspection lots.

2. The `ballerinax/sap.s4hana.api_inspectionmethod_srv` package provides APIs that enable seamless integration with
   the [Inspection Method - Read API v2.0.0](https://api.sap.com/api/API_INSPECTIONMETHOD_SRV/overview). This service enables you to retrieve inspection methods with their settings and administrative data.

3. The `ballerinax/sap.s4hana.api_inspectionplan_srv` package provides APIs that enable seamless integration with
   the [Inspection Plan API v1.0.0](https://api.sap.com/api/API_INSPECTIONPLAN_SRV/overview). This service enables you to read, create, update, and delete inspection plan header data.

4. The `ballerinax/sap.s4hana.api_masterinspcharacteristic_srv` package provides APIs that enable seamless integration with
   the [Master Inspection Characteristic - Read API v2.0.0](https://api.sap.com/api/API_MASTERINSPCHARACTERISTIC_SRV/overview). This service allows to read quality inspection specifications of the type master inspection characteristic.

5. The `ballerinax/sap.s4hana.api_qualityinforecord_srv` package provides APIs that enable seamless integration with
   the [Quality Info Record API v1.2.0](https://api.sap.com/api/API_QUALITYINFORECORD_SRV/overview). This service allows to create, read, update, and delete data related to quality info records and first article inspection.

 6. The `ballerinax/sap.s4hana.api_charcattributecatalog_srv` package provides APIs that enable seamless integration with
   the [Characteristic Attribute Catalog - Read API v1.0.0](https://api.sap.com/api/API_CHARCATTRIBUTECATALOG_SRV/overview). This service allows to read plant-specific selected sets with their codes that are used to record inspection results for qualitative characteristics.

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

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To build only one specific package

   ```bash
   ./gradlew clean :qm-ballerina:<api_name>:build
   ```

   |           API Name               |                     Connector                          |
   | -------------------------------- | ------------------------------------------------------ |
   | api_inspectionlot_srv            | ballerinax/sap.s4hana.api_inspectionlot_srv            |
   | api_inspectionplan_srv           | ballerinax/sap.s4hana.api_inspectionplan_srv           |
   | api_masterinspcharacteristic_srv | ballerinax/sap.s4hana.api_masterinspcharacteristic_srv |
   | api_inspectionmethod_srv         | ballerinax/sap.s4hana.api_inspectionmethod_srv         |
   | api_qualityinforecord_srv        | ballerinax/sap.s4hana.api_qualityinforecord_srv        |
   | api_charcattributecatalog_srv    | ballerinax/sap.s4hana.api_charcattributecatalog_srv    |

5. To run tests against different environment:

   ```bash
   isTestOnLiveServer=true ./gradlew clean test 
   ```
   **Note**: `isTestOnLiveServer` is false by default, tests are run against mock server.

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

For more information, go to 
the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`sap` package](https://lib.ballerina.io/ballerinax/sap/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with 
  the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
