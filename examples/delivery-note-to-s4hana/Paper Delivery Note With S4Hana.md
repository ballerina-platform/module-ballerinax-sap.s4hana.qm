# Extract data from paper delivery note and integrate with S/4HANA

This example demonstrates how to use Ballerina's `sap.s4hana.api_inspectionlot_srv:Client` to interact with S/4HANA API.
Optical character recognition (OCR) with [Eden AI](https://www.edenai.co/) API is used to extract data from a physical
delivery note.
The data is then used to establish an inspection lot to initiate the inspection process in the S/4HANA QM module.

## Prerequisites

### 1. Setup an Eden AI account

Create an Eden AI account. Generate an API token and save it for later use, as specified in the Configuration section.

### 2. Setup the S/4HANA API

Refer to the [Setup Guide](https://central.ballerina.io/ballerinax/sap/latest#setup-guide) for necessary credentials (
hostname, username, password).

### 2. Configuration

In the example directory, create a Config.toml file and configure InspectionLot and S/4HANA API credentials as shown
below:

```toml
ocrToken = "<Token>"
invoiceUrl = "<invoiceUrl>" # Optional. URL the invoice to be processed is exposed

[s4hanaClientConfig]
hostname = "<Hostname>"
username = "<Username>"
password = "<Password>"
```

## Run the Example

Execute the following command to run the example:

```bash
bal run
```
