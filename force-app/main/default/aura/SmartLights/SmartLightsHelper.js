({
	getLights: function(component) {

        var demoMode = component.get("v.demoMode");
        if (demoMode) {
            component.set("v.waiting", true);
            setTimeout($A.getCallback(function() {
	            component.set("v.waiting", false);
                var lights = [];
                lights.push({label: "Living Room", power:"off", brightness: 75});
                lights.push({label: "Kitchen", power:"off", brightness: 75});
                component.set("v.lights", lights);
            }), 1);
        } else {
            var action = component.get("c.getLights");
            action.setCallback(this, function(response) {
                component.set("v.waiting", false);
                var lights = JSON.parse(response.getReturnValue());
                component.set("v.lights", lights);
            });
            component.set("v.waiting", true);
            $A.enqueueAction(action);
        }

	},

	setPower: function(component, lightId, isOn) {
        var demoMode = component.get("v.demoMode");
        if (!demoMode) {
            var action = component.get("c.setPower");
            action.setParams({
                "lightId": lightId,
                "isOn": isOn
            });
            action.setCallback(this, function() {
            });
            $A.enqueueAction(action);
        }
	},

	setBrightness: function(component, lightId, brightness) {
        var demoMode = component.get("v.demoMode");
        if (!demoMode) {
            var action = component.get("c.setBrightness");
            action.setParams({
                "lightId": lightId,
                "brightness": brightness
            });
            action.setCallback(this, function() {
            });
            $A.enqueueAction(action);
        }
	}

})