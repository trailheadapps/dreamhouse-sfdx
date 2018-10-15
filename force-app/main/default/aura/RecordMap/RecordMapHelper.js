({
    reloadRecord : function(component) {
        var service = component.find("service");
        service.reloadRecord(false, function() {
            var sObject = component.get("v.sObject");
            component.set("v.mapMarkers", [
                {
                    location: {
                        Latitude: sObject[component.get("v.latField")],
                        Longitude: sObject[component.get("v.longField")]
                    }
                }
            ]);
        });
	}

})