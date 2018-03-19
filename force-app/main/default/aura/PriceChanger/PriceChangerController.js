({
    onJSLoaded : function(component, event, helper) {
        component.set("v.recordId", window.recordId);
        var propertyService = component.find("propertyService");
        propertyService.reloadRecord();
    },

    onPriceChange : function(component, event, helper) {
        var property = component.get("v.property");
        // var price = component.get("v.price");
        // property.Monthly_Rent__c = price;
        property.Monthly_Rent__c = event.getParam("value");
        component.find("propertyService").saveRecord($A.getCallback(function(saveResult) {
        }));
    },

})
