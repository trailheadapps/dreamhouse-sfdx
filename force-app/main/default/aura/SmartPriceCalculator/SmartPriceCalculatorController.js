({
	onRecordSelected : function(component, event) {
        var id = event.getParam("recordId");
        component.set("v.recordId", id);
        var service = component.find("propertyService");
        service.reloadRecord();
        var smartPrice = component.find("smartPrice");
        if (smartPrice) {
            smartPrice.getElement().innerHTML = "";
            component.find("currency").getElement().innerHTML="";
        }
	},

    onRecordUpdated : function(component, event) {
		var changeType = event.getParams().changeType;
        if (changeType === "CHANGED") { 
            var service = component.find("propertyService");
            service.reloadRecord();
        }
    },

    onSmartPriceBtnClicked : function(component, event, helper) {
		var property = component.get("v.property");
        if (property) {
            helper.getSmartPrice(component, function(smartPrice) {
                component.set("v.smartPrice", smartPrice);
                var smartPriceEl = component.find("smartPrice").getElement();
                var currencyEl = component.find("currency").getElement();
                currencyEl.innerHTML = '$';
                var numAnim = new CountUp(smartPriceEl, smartPrice * 0.8, smartPrice, 0, 2);
                numAnim.start();
            });
        }
    },

    onSavePriceBtnClicked : function(component, event) {
        var property = component.get("v.property");
        if (property) {
            property.Price__c = component.get("v.smartPrice");
            component.find("propertyService").saveRecord();
        }
    }

})