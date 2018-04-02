({
    onJSLoaded : function(component, event, helper) {
        component.set("v.recordId", window.recordId);
        var propertyService = component.find("propertyService");
        propertyService.reloadRecord();
    },

    onPriceChange : function(component, event, helper) {
        var property = component.get("v.property");
        property.Price__c = event.getParam("value");
    },

    savePrice : function(component, event, helper) {
        component.find("propertyService").saveRecord($A.getCallback(function(saveResult) {
        }));
    },


})