({
    calculateMonthlyPayment : function(component, event, helper) {
        helper.calculateMonthlyPayment(component);
	},

    recordUpdated : function(component) {
        component.set("v.principal", component.get("v.property").Price__c);
	}
})