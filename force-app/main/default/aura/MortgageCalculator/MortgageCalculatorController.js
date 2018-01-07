({
    calculateMonthlyPayment : function(component, event, helper) {
        helper.calculateMonthlyPayment(component);
	},

    recordUpdated : function(component) {
        var property = component.get("v.property");
        if (property) {
            component.set("v.principal", property.Price__c);
        }
	}
})