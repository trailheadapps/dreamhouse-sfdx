({
    navigateToRecord : function (component, event, helper) {
        var selectedItem = event.currentTarget;
        var recordId = selectedItem.dataset.record;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId,
        });
        navEvt.fire();
    },
    
    recordUpdated : function(component, event, helper) {
        var changeType = event.getParams().changeType;
        if (changeType === "LOADED" || changeType === "CHANGED") {
            helper.loadSimilarProperties(component);
        }
    },
    
    recordChangeHandler : function(component, event) {
        var id = event.getParam("recordId");
        component.set("v.recordId", id);
        var service = component.find("service");
        service.reloadRecord();
    }


 })