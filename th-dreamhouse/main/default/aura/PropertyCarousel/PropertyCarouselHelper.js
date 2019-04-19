({
    loadPictures : function(component) {
        var propertyId = component.get("v.recordId");
        component.set("v.files", []);
        if (!propertyId) {
            return;
        }
        var action = component.get("c.getPictures");
        action.setParams({
            "propertyId": propertyId,
        });
        action.setCallback(this, function (response) {
            var files = response.getReturnValue();
            component.set("v.files", files);
        });
        $A.enqueueAction(action);
    }
})