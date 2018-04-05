({
    onRecordSelected : function(component, event) {
        var id = event.getParam("recordId");
        component.set("v.recordId", id);
        var service = component.find("propertyService");
        service.reloadRecord();
	},

    onRecordUpdated : function(component, event, helper) {
		var changeType = event.getParams().changeType;
        if (changeType === "CHANGED") {
            var service = component.find("propertyService");
            service.reloadRecord();
        } else {
            var property = component.get("v.property");
            helper.setFormattedPrice(component, property.Price__c);
            helper.calculateDays(component, helper, property.Price__c);
        }
    },

    // Sliding price range input
    onPriceInput: function(component, event, helper) {
        helper.setFormattedPrice(component, event.target.value);
    },

    // Releasing price range input
	onPriceChange: function(component, event, helper) {
        var property = component.get("v.property");
        var newPrice = event.target.value;
        property.Price__c = newPrice;
        helper.calculateDays(component, helper, newPrice);
    },

    onSavePriceBtnClicked : function(component) {
        var property = component.get("v.property");
        if (property) {
            component.find("propertyService").saveRecord();
        }
    }

})