({
    importData : function(component, event, helper) {
        var action = component.get("c.importSampleData");
        component.set("v.showSpinner", true);
        action.setCallback(this, function (response) {
            component.set("v.showSpinner", false);
            var state = response.getState();
            if (state === "SUCCESS") { 
                component.find('notifLib').showToast({
                    "variant": "success",
                    "header": "Success",
                    "message": "Sample data successfully imported.",
                });
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Sample data import failed"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})
