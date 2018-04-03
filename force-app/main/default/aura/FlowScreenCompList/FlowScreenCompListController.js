({
    onInit: function(component, event, helper) {

        component.set('v.columns', [
        	{label: 'Address', fieldName: 'Address__c', type: 'text', initialWidth: 150},
            {label: 'City', fieldName: 'City__c', type: 'text'},
            {label: 'Beds', fieldName: 'Beds__c', type: 'number'},
            {label: 'Baths', fieldName: 'Baths__c', type: 'number'},
            {label: 'Price', fieldName: 'Price__c', type: 'currency'},
            {label: 'Predicted Days', fieldName: 'Predicted_Days_On_Market__c', type: 'number', initialWidth: 160}
        ]);

        var action = component.get("c.getComparableProperties");
        action.setStorable();
        action.setParams({
            propertyId: component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            component.set("v.comparableProperties", response.getReturnValue());
        });
        $A.enqueueAction(action);

    },

})