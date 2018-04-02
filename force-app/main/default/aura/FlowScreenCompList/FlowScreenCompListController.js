({
    onJSLoaded: function(component, event, helper) {

        component.set("v.recordId", window.recordId);

        component.set('v.columns', [
        	{label: 'Address', fieldName: 'Address__c', type: 'text', initialWidth: 150},
            {label: 'City', fieldName: 'City__c', type: 'text'},
            {label: 'Price', fieldName: 'Price__c', type: 'currency'},
            {label: 'Beds', fieldName: 'Beds__c', type: 'number'},
            {label: 'Baths', fieldName: 'Baths__c', type: 'number'},
            {label: 'SQFT', fieldName: 'Sqft__c', type: 'number'},
            {label: 'Predicted Days', fieldName: 'Days_Prediction__c', type: 'number', initialWidth: 160}
        ]);

        helper.loadComparableRentals(component);

    },

})