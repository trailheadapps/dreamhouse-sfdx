({
    doInit : function(component, event, helper) {
        component.set("v.fields", ["Id", component.get("v.latField"), component.get("v.longField"), component.get("v.titleField")]);
        var recordId = component.get("v.recordId");
        component.set("v.dsRecordId", recordId);
        helper.reloadRecord(component);
	},

  	recordChangeHandler : function(component, event, helper) {
        console.log('recordChangeHandler');
        var id = event.getParam("recordId");
        component.set("v.dsRecordId", id);
        helper.reloadRecord(component);
	},

  	onRecordUpdated : function(component, event) {
        console.log('onRecordUpdated');
        var sObject = component.get("v.sObject");
        if (sObject) {
	        component.set("v.title", sObject[component.get("v.titleField")]);
            component.set("v.mapMarkers", [
                {
                    location: {
                        Latitude: sObject[component.get("v.latField")],
                        Longitude: sObject[component.get("v.longField")]
                    }
                }
            ]);
        }
    }
})