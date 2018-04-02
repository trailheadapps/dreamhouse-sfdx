({
    onJSLoaded : function(component, event, helper) {
        component.set("v.recordId", window.recordId);
        var propertyService = component.find("propertyService");
        propertyService.reloadRecord();
    },
})