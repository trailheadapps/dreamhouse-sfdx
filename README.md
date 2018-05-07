# DreamHouse Sample Application

[![Deploy](https://deploy-to-sfdx.com/dist/assets/images/DeployToSFDX.svg)](https://deploy-to-sfdx.com)

Dreamhouse is a sample application for the real estate business built on the Salesforce platform. It allows brokers to manage their properties and customers to find their dream house.

Features demonstrated in DreamHouse include:
- Lightning Components
- Lightning Components in Quick Actions
- Lightning Components in Utility Bar
- Lightning Base Components
- Lightning Data Service
- Standard events (force:navigateToSObject, force:editRecord, ltng:selectSObject)
- Process automation with Process Builder
- Reports and Dashboards
- Einstein Vision
- Salesforce mobile app

There are also a number of apps built on top of DreamHouse that demonstrate additional features:
- Customer-facing mobile application with the Salesforce Mobile SDK (Ionic and React Native)
- Bot integration (Facebook Messenger, Slack, and Alexa)
- IoT integration (smart lights, smart locks, smart thermostat)

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
DreamHouse features a large number of Lightning Components that enhance the broker experience. Lightning Components can be added to the home page, to a record page, to an app page, in a quick action, or in the utility bar.

### Lightning Components in Quick Actions

Lightning actions are quick or global actions implemented with a Lightning component. An action can be a great alternative to adding a component to a page layout because the component instantiation is deferred until the action button is clicked (lazy instantiation). Installing less frequently used components as quick or global actions can contribute to a faster page loading time, and a streamlined user interface. In the DreamHouse application, the SmartHome component is used as a quick action on the Property record page.

### Lightning Components in Utility Bar

Lightning components can also be used in the utility bar. Utility bar components are always at your fingertips. In the DreamHouse app, there are two components in the utility bar: Bot and MortgageCalculator

### Lightning Data Service

The Lightning Data Service allows you to work with Salesforce records without writing  server-side (Apex) code. The Lightning Data Service automatically fetches records from the server when requested the first time, stores them in a highly efficient client cache, and shares them between all components that request them. This also ensures UI consistency across components: When the user changes the data in one component, the other components automatically show the new values. In DreamHouse, all the Lightning components that deal with a single Property record use the Lightning Data Service. For example: PropertySummary, PropertyMap, and PropertyDaysOnMarketChart.

### Third-Party libraries (Map Component)

Before you decide to use a third-party library in a Lightning component, make sure you really need it. DOM manipulation libraries and UI libraries in particular often aren’t needed when working with a framework like the Lightning Component Framework. Read this blog post for details. The DreamHouse sample application uses the Leaflet map library.
```
<ltng:require styles="{!$Resource.leaflet + '/leaflet.css'}"
              scripts="{!$Resource.leaflet + '/leaflet.js'}"
              afterScriptsLoaded="{!c.jsLoaded}" />
```

### Custom page templates

Custom Page Templates allow you to create ad hoc page layouts that admins can use in App Builder to create new pages. In Dreamhouse, the Property Explorer uses a custom page template (PageTemplate_2_6_4) to allow you to take full control over the width of each column in a three column layout.

### Lightning Base Component
DreamHouse custom components are built leveraging the [Lightning Base Components](). For example:
- PropertyCarousel is built using lightning:fileUpload and lightning:carousel
- PropertySummary leverages lightning:formattedAddress and lightning:formattedNumber.

https://<mydomain>.lightning.force.com/componentReference/suite.app?page=lightning:clickToDial
https://developer.salesforce.com/docs/component-library/overview/components

### Process automation with Process Builder

### Einstein Vision

Home buyers may know the type of house they like when they see it, but they may not always know how that type of house is called (Victorian, Colonial, Greek Revival, etc …). Visual search, powered by Einstein Vision, can help prospective home buyers find similar houses based on the picture of a house they like. The new Property Finder makes it easy to perform that type of visual search. Just select or drag a picture of a house you like. Instructions to enable visual search are available here.

Optional instruction to enable visual search in the **Property Finder** and **Property Explorer** pages:

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

### Reports and dashboards

Reports and dashboards are easy to create and look great in Lightning. Just to get things started, the DreamHouse app now includes a few reports in the DreamHouse Reports folder:
- Days on Market
- Properties by Broker
- Portfolio Health

### Standard application events
Standard application events are application events that are available by default in the framework.  DreamHouse uses a number of standard application events. For example:
- force:navigateToSObject is used in the PropertyTile component to ask the framework to navigate to the specified record. Use this approach instead of linking directly to specific URL fragments, which is not supported (URL fragments are subject to change).
- force:editRecord is used in the PropertySummary component to provide a dialog to edit a record “in place.”
- ltng:selectSObject is used in the PropertyTile component to notify other components that a new record has been selected. Other components like PropertySummary and PropertyMap listen to that event to display data for the selected record. This event is often used to implement master/details interfaces like in the Property Explorer and Command Center pages.

### Custom Application Events 
Limit the use of application events to coarse-grained application-level communication, such as communication between components added to pages with App Builder. For example, in DreamHouse:

The PropertyFilterChange event is fired in the PropertyFilter component to notify other components that the user selected a new filter criteria.

### Component events
Use component events for finer-grained communication between components. For example, in DreamHouse, the PropertyPaginator component fires the pageNext and pagePrevious events to notify its parent (PropetyTileList) that the user requested the next or previous page.

PropetyTileList (parent):
```
<aura:iteration items="{!v.properties}" var="property">
    <c:PropertyTile property="{#property}" />
</aura:iteration>

<c:PropertyPaginator
    pagePrevious="{!c.onPagePrevious}"
    pageNext="{!c.onPageNext}"/>
```

PropertyPaginator (child):
<!-- Markup -->
```
<aura:registerEvent name="pagePrevious" type="c:PropertyPageChange"/>
<aura:registerEvent name="pageNext" type="c:PropertyPageChange"/>

<lightning:buttonIcon iconName="utility:left" onclick="{!c.previousPage}"/>
<lightning:buttonIcon iconName="utility:right" onclick="{!c.nextPage}"/>
```

// controller
```
previousPage : function(component) {
        var pageChangeEvent = component.getEvent("pagePrevious");
        pageChangeEvent.fire();
},

nextPage : function(component) {
        var pageChangeEvent = component.getEvent("pageNext");
        pageChangeEvent.fire();
}
```

### Many more features

The DreamHouse sample application has many more features not discussed in this article which focuses on the latest additions to the app. For example, DreamHouse also demonstrates how to:

Use the Salesforce Mobile App
Create a customer engagement mobile app with the Mobile SDK
Automate processes with Process Builder, including sending push notification messages to the customer engagement app
Integrate with Alexa, Slack, and Facebook Messenger
Integrate with IoT devices like smart lights, smart thermostats, and smart locks
Head over to dreamhouseapp.io to explore all the features available in the DreamHouse sample app.