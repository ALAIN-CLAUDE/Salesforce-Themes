# Salesforce API Inspector

## Overview

Salesforce API Inspector is an open-source Lightning Web Component (LWC) tool designed to help Salesforce developers easily test and inspect APIs within Salesforce. This component allows developers to make API calls, view responses, generate mock data, and save request history.

## Features

- **API Endpoint Tester**: Input API details and execute requests.
- **Response Viewer**: Displays the API response in a readable format.
- **Request History**: Keeps a history of past API requests.
- **Mock Data Generator**: Creates sample JSON payloads for testing.

## Setup

### Prerequisites

- **Salesforce CLI**: Ensure you have Salesforce CLI installed. Follow the [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm) for installation instructions.
- **Dev Hub**: Make sure you have a Dev Hub org enabled, or use an existing Salesforce org for development.
- **Visual Studio Code**: Install Visual Studio Code and Salesforce Extensions for VS Code. See the [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/) for details.

### Installation Steps

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-repo/salesforce-api-inspector.git
    cd salesforce-api-inspector
    ```

2. **Authorize a Salesforce Org**:
    Authorize your Salesforce org (Dev Hub or scratch org) using the Salesforce CLI:
    ```bash
    sfdx auth:web:login -d -a myorg
    ```

3. **Deploy to Salesforce**:
    Use Salesforce CLI or VS Code to deploy the source code to your Salesforce org:
    ```bash
    sfdx force:source:deploy -p force-app
    ```

4. **Assign Permission Set**:
    Assign the `API_Inspector_User` permission set to users who need access to the component:
    ```bash
    sfdx force:user:permset:assign -n API_Inspector_User
    ```

5. **Add the Component to Your App**:
    In Salesforce, navigate to the Lightning App Builder and drag the "Salesforce API Inspector" component onto your desired app page.

6. **Test the Component**:
    Open the app in Salesforce and test the Salesforce API Inspector by entering API details and sending a request.

## Usage

1. Navigate to the app where you've added the Salesforce API Inspector component.
2. Input the necessary API details (method, endpoint, headers, body).
3. Click "Send Request" to see the API response.
4. View and manage your API request history.

## Contributing

We welcome contributions from the community! Here are a few issues you can work on:

1. **Enhance UI/UX**: Improve the overall design and user experience of the component.
2. **Add Support for Other HTTP Methods**: Extend support for PATCH, DELETE, and others.
3. **Integrate with External Tools**: Allow exporting history to CSV or connecting with external services like Postman.
4. **Create Unit Tests**: Add Jest tests for all LWC components.
5. **Implement Error Handling**: Improve error handling and display meaningful messages to users.

## License

This project is licensed under the MIT License.

# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
