({
    /*
    When a new Property is selected (in another component), load the corresponding
    property record.
    */
    onPropertySelected: function (component, event) {
        component.set("v.recordId", event.getParam("recordId"));
        var propertyService = component.find("propertyService");
        propertyService.reloadRecord();
    },

    editRecord: function (component, event, helper) {
        var recordId = component.get("v.recordId")
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": recordId
        });
        editRecordEvent.fire();
    },

    navigateToRecord : function(component, event) {
	    var navigateEvent = $A.get("e.force:navigateToSObject");
        navigateEvent.setParams({"recordId": component.get("v.brokerId"), slideDevName: "detail"});
	    navigateEvent.fire();
    }

})