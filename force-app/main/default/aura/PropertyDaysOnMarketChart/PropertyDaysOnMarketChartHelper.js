({
	showDaysOnMarket : function(component) {
    	var property = component.get("v.property");
        var daysOnMarket = property.Days_On_Market__c;
        var status = "green";
        if (daysOnMarket > 60) {
            status = 'red';
        } else if (daysOnMarket > 30) {
            status = 'orange'
        }
        component.set("v.status", status);
        component.set("v.formattedDateListed", new Date(property.Date_Listed__c).toLocaleString('en-US', {month: 'short', year: 'numeric', day: 'numeric'}));
	}
})