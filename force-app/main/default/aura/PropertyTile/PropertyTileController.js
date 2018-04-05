({
	navigateToDetailsView : function(component) {
		var property = component.get("v.property");
        var myEvent = $A.get("e.force:navigateToSObject");
        myEvent.setParams({
            "recordId": property.Id
        });
        myEvent.fire();
	},

	propertySelected : function(component) {
		var property = component.get("v.property");
        var myEvent = $A.get("e.ltng:selectSObject");
        myEvent.setParams({"recordId": property.Id, channel: "Properties"});
        myEvent.fire();
    }

})