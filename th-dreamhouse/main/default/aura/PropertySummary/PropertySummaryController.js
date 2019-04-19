({
    /*
    When a new Property is selected (in another component), load the corresponding
    property record.
    */
    recordChangeHandler: function (component, event) {
        console.log(component.get("v.property"));
        component.set("v.recordId", event.getParam("recordId"));
        var service = component.find("service");
        service.reloadRecord();    
    },

    editRecord: function (component, event, helper) {
        var recordId = component.get("v.recordId")
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": recordId
        });
        editRecordEvent.fire();
    },

    navigateToBrokerRecord : function(component, event) {
	    var navigateEvent = $A.get("e.force:navigateToSObject");
        navigateEvent.setParams({"recordId": component.get("v.property").Broker__r.Id, slideDevName: "detail"});
	    navigateEvent.fire();
    }

})