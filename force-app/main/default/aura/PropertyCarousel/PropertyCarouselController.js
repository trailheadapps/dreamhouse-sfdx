({
    onInit : function(component) {
        var action = component.get("c.getPictures");
        action.setParams({
            "propertyId": component.get("v.recordId"),
        });
        action.setCallback(this, function (response) {
            component.set("v.files", response.getReturnValue());
        });
        $A.enqueueAction(action);
    }

})