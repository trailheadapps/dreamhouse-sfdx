({
    loadSimilarProperties : function(component) {
        var property = component.get("v.property");
        var action = component.get("c.getSimilarProperties");
        action.setStorable();
        action.setParams({
            propertyId: property.Id,
            price: property.Price__c,
            bedrooms: property.Beds__c,
            searchCriteria: component.get("v.searchCriteria")
        });
        action.setCallback(this, function(response){
            component.set("v.similarProperties", response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
})