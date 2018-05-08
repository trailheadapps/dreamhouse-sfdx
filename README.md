# DreamHouse Sample Application

[![Deploy](https://deploy-to-sfdx.com/dist/assets/images/DeployToSFDX.svg)](https://deploy-to-sfdx.com)

Dreamhouse is a sample application for the real estate business built on the Salesforce platform. It allows brokers to manage their properties and customers to find their dream house.

## Installation Instructions

1. Install Salesforce DX. Enable the Dev Hub in your org or sign up for a Dev Hub trial org and install the Salesforce DX CLI. Follow the instructions in the [Salesforce DX Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm?search_text=trial%20hub%20org) or in the [App Development with Salesforce DX](https://trailhead.salesforce.com/modules/sfdx_app_dev) Trailhead module.

1. Clone the **dreamhouse-sfdx** repository:
    ```
    git clone https://github.com/dreamhouseapp/dreamhouse-sfdx
    cd dreamhouse-sfdx
    ```

1. Create a scratch org and provide it with an alias of your choice (dh in the command below):
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

1. Select **DreamHouse** in the App Launcher

1. Click the **Data Import** tab and click **Initialize Sample Data**

## Code Highlights

### Lightning Components
DreamHouse features a large number of Lightning Components that enhance the user experience. Lightning Components are used on the Property record page, on an app pages (Property Finder and Property Explorer), in the utility bar, and as quick actions.

### Lightning Data Service
Lightning Data Service allows you to manipulate (retrieve, create, update, delete) Salesforce records without writing server-side (Apex) code. In DreamHouse, all the Lightning components that deal with a single Property record use Lightning Data Service. Check out [PropertySummary]((force-app/main/default/aura/PropertySummary) for an example.

### Lightning Components in Quick Actions
A Quick action can be implemented with a Lightning Component and can be a great alternative to adding a component to a page layout because the component instantiation is deferred until the action button is clicked (lazy instantiation). Installing less frequently used components as quick or global actions can contribute to a faster page loading time, and a streamlined user interface. In the DreamHouse application, the [SmartHome](force-app/main/default/aura/SmartHome) component is used as a quick action on the Property record page.

### Lightning Components in Utility Bar
The utility bar is great for components you always want at your fingertips. [MortgageCalculator](force-app/main/default/aura/SmartHome) is a great example.

### Third-Party JavaScript libraries
You can use third-party JavaScript libraries in Lightning Components. For example:
- [Map](force-app/main/default/aura/Map) and [PropertyListMap](force-app/main/default/aura/PropertyListMap) use the [Leaflet](https://leafletjs.com/) library.
- [PriceRange](force-app/main/default/aura/PropertyListMap) uses the [nouislider](https://refreshless.com/nouislider/) library's double slider.

### Custom page templates
Custom Page Templates allow you to create ad hoc page layouts that admins can use in App Builder to create new pages. Custom Page Templates are implemented as Lightning Components. There are two custom page templates in Dreamhouse: [PageTemplate_2_6_4]((force-app/main/default/aura/PageTemplate_2_6_4/PageTemplate_2_6_4.cmp) (used by the Property Finder page) and [PageTemplate_2_7_3](force-app/main/default/aura/PageTemplate_2_7_3/PageTemplate_2_7_3.cmp) (used by the Property Explorer page). They provide custom three column layouts using different relative widths for each column.

### Base Lightning Component
Base Lightning Components are a set of powerful UI components available in the Lightning Component Framework. The DreamHouse custom components leverage many Base Lightning Components. For example, the [PropertyCarousel](force-app/main/default/aura/PropertyCarousel/PropertyCarousel.cmp) component which allows you to navigate through the pictures of a property and allows you to upload new pictures is built using lightning:carousel and lightning:fileUpload. [PropertySummary](force-app/main/default/aura/PropertySummary/PropertySummary.cmp) leverages lightning:formattedAddress and lightning:formattedNumber.

### Standard application events
Standard application events are available by default in the framework and are used to trigger high level actions/ For example, in [PropertySummary](force-app/main/default/aura/PropertySummary/PropertySummaryController.js), force:navigateToSObject is used to navigate to a record, and force:editRecord is used to edit a record "in place."

### Custom Application Events 
Application events are used for communication between components in App Builder. For example, the PropertyFilterChange event is fired in the [PropertyFilter](force-app/main/default/aura/PropertyProperty) component to notify other components that the user selected new filter criteria.

### Component events
Component events are used for finer-grained communication between components. For example, the [PropertyPaginator](force-app/main/default/aura/PropertyProperty) component fires the pageNext and pagePrevious events to notify its parent ([PropetyTileList](force-app/main/default/aura/PropertyTileList)) that the user requested the next or previous page.

### Reports and dashboards
Reports and dashboards are easy to create and look great in Lightning. Just to get things started, the DreamHouse app includes a few reports in the DreamHouse Reports folder:
- Days on Market
- Properties by Broker
- Portfolio Health

### Einstein Vision
The PropertyFilter component leverages Einstein Vision to provide a visual search feature that allows home buyers to find houses based on the picture of a house they like. Just select or drag a picture: Einstein Vision will recognize the type of house (colonial, victorian, or contemporary) and you are presented of a list of houses matching that category. Follow the instructions below to enable visual search in the **Property Finder** and **Property Explorer** pages:

1. Get an **Einstein Platform Services** account. Follow the instructions [here](https://github.com/dreamhouseapp/dreamhouse-sfdx/tree/spring18).

1. In Salesforce, click the **Files** tab and upload **einstein_platform.pem**.

1. In **Setup**, type **Custom** in the Quick Find box and click the **Custom Settings** link.

1. Click the first **New** Button (at the top of the screen).

1. For **Einstein Vision Email**, specify the email address you used when you created your Einstein Platform Services account (step 1), and click **Save**.

1. In the DreamHouse app, click the **Einstein Vision** tab.

1. Click the **Create Dataset** button.

1. In the **houses** tile, click the **Train** button, the click the **Models** tab.

1. Click the **Refresh Models** button until the Progress column indicates **100%**.

1. Copy the **Model Id** in your clipboard.

1. Click the **Property Finder** Tab, click the gear icon (upper right corner), and click **Edit Page**. Click the **Filters** component and paste the Model Id in the **Einstein Model Id** field in the right sidebar. Save the page.

1. Repeat the last step for the **Property Explorer** page.

You can now search houses by uploading (or dropping) a picture in the visual search box that is part of the Filters component on the **Property Finder** and **Property Explorer** pages. 

### Many more features
The DreamHouse sample application has many more features not discussed in this article which focuses on the latest additions to the app. For example, DreamHouse also demonstrates how to:

- Use the Salesforce Mobile App
- Create a customer engagement mobile app with the Mobile SDK
- Automate processes with Process Builder, including sending push notification messages to the customer engagement app
- Integrate with Alexa, Slack, and Facebook Messenger
- Integrate with IoT devices like smart lights, smart thermostats, and smart locks

Head over to [dreamhouseapp.io](http://dreamhouseapp.io) to explore all the features available in the DreamHouse sample app.