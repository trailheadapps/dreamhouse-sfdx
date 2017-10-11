# DreamHouse Sample Application

DreamHouse is a sample application that demonstrates the unique value proposition of the Salesforce App Cloud for building Employee Productivity and Customer Engagement apps.

Check out the [DreamHouse microsite](http://www.dreamhouseapp.io/) for more information.

[![Deploy](https://deploy-to-sfdx.com/dist/assets/images/DeployToSFDX.svg)](https://deploy-to-sfdx.com/)

## Salesforce DX Documentation Links
[Salesforce DX Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)

[Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)

[Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

[Visual Studio Code Extension Pack for Salesforce DX](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode)

[Force.com IDE 2 Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_ide2.meta/sfdx_ide2/sfdx_ide2_get_started.htm)

## Installation Instructions

1. Install Salesforce DX. Enable the Dev Hub in your org or sign up for a Dev Hub trial org and install the Salesforce DX CLI. Follow the instructions in the [Salesforce DX Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm?search_text=trial%20hub%20org) or in the [App Development with Salesforce DX](https://trailhead.salesforce.com/modules/sfdx_app_dev) Trailhead module.

1. Clone the **dreamhouse-sfdx** repository:
    ```
    git clone https://github.com/dreamhouseapp/dreamhouse-sfdx
    cd dreamhouse-sfdx
    ```

1. Create a scratch org and provide it with an alias (dh):
    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a dh
    ```

1. Push the app to your scratch org:
    ```
    sfdx force:source:push
    ```

1. Assign the **dreamhouse** permission set to the default user:
    ```
    sfdx force:user:permset:assign -n dreamhouse
    ```

1. Open the scratch org:
    ```
    sfdx force:org:open
    ```

1. In **Setup**, type **theme** in the quick find box. Click **Themes and Branding**, and flip the toggle to hide background images in Lightning Experience.

1. Select **DreamHouse** in the App Launcher

1. Click the **Data Import** tab and click **Initialize Sample Data**
