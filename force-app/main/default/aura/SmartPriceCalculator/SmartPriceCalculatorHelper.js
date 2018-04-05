({
    getSmartPrice: function(component, callback) {
        // Stubbed service call. Make call to PredictionIO here.
        // More info: http://www.dreamhouseapp.io/pio/
		var property = component.get("v.property");
        component.set("v.waiting", true);
		window.setTimeout($A.getCallback(function() {
            component.set("v.waiting", false);
            if (component.isValid()) {
                var smartPrice = Math.round(property.Assessed_Value__c * 1.15 / 1000) * 1000;
                callback(smartPrice);
            }
        }), 300);
    }
})