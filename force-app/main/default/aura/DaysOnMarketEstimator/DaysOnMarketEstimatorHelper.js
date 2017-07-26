({
	setFormattedPrice: function(component, price) {
		var formattedPrice = Number(price).toLocaleString("en-US", {style: "currency", currency: 'USD'});
		component.set("v.formattedPrice", formattedPrice);
	},

    calculateDays: function(component, helper, price) {
        var property = component.get("v.property");
        var ellapsed = (new Date() - new Date(property.Date_Listed__c)) / 24 / 60 / 60 / 1000;
        var currentDays = component.get("v.days") || ellapsed;
        component.set("v.waiting", true);
        helper.predictDaysOnMarket(component, property, price, function(days) {
            if (component.isValid()) {
                component.set("v.waiting", false);
                var color = '#00716B';
                if (days > 60) {
                    color = '#C23934';
                } else if (days > 30) {
                    color = '#FFB75D';
                }
                component.set("v.color", color);
                var daysEl = component.find("days").getElement();
                var daysAnim = new CountUp(daysEl, currentDays, days, 0, 2);
                daysAnim.start();
                component.set("v.days", days);
            }
        });
    },
    
    predictDaysOnMarket: function(component, property, price, callback) {
        // Stubbed service call. Make call to PredictionIO here.
        // More info: http://www.dreamhouseapp.io/pio/
        window.setTimeout($A.getCallback(function() {
			if (component.isValid()) {
                var days;
                var assessedValue = property.Assessed_Value__c;
                if (price < assessedValue) {
                    days = 2;
                } else if (price < assessedValue * 1.1) {
                    days = price / assessedValue * 10;
                } else if (price < assessedValue * 1.2) {
                    days = price / assessedValue * 30;
                } else if (price < assessedValue * 1.3) {
                    days = price / assessedValue * 40;
                } else if (price < assessedValue * 1.4) {
                    days = price / assessedValue * 60;
                } else {
                    days = 90;
                }
                callback(days);
            }
        }), 300);
	}

})