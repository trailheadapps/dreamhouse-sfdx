({
    getYelpData: function(component) {
        var searchTerm = component.get("v.searchTerm");
        var action;

        if (component.get("v.address")) {
            action = component.get("c.getListByAddress");
            action.setParams({
            	"address": component.get("v.address"),
                "searchTerm": searchTerm
            });
        } else if (component.get("v.latlon")) {
            action = component.get("c.getListByLatLon");
            action.setParams({
            	"latlon": component.get("v.latlon"),
                "searchTerm": searchTerm
            });
        }
        if (action) {
	        action.setCallback(this, function(response) {
	        	console.log("In the callback in the service for getYelpData...");
	            this.handleYelpData(response, component);
	        });
	        action.setStorable();
	        $A.enqueueAction(action);
	    }
    },

    handleYelpData: function(response, component) {
        var state = response.getState();
        console.log("Handling Yelp data...");
        debugger;
        if (state === 'ERROR') {
            component.set("v.errorMessage", "We got lost on the way to the data.");
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "type": "error",
                "title": "Ooops!",
                "message": 'A really bad thing happened on the way to retrieving your data.',
                "mode": "sticky"
            });
            toastEvent.fire();
        } else if (state === 'SUCCESS') {
            var data = JSON.parse(response.getReturnValue());
            if (data.error) {
                component.set("v.errorMessage", data.error);
            } else if (data.bizArray) {
            	var yelpEvent = component.getEvent("yelpDataFound");
                yelpEvent.setParams( { locationUsed: data.location, resultList: data.bizArray } );
                yelpEvent.fire();
            }
        }
    }
})