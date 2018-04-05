({

    jsLoaded: function(component) {
        component.set("v.jsLoaded", true);
    },
    
    setLocation: function(component, event, helper) {
		var params = event.getParam('arguments');
        if (params) {
            component.set("v.location", {
                lat: params.lat,
                long: params.long
            });
        }
    }

})