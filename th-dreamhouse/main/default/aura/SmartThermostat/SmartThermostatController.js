({
	sliderInputHandler : function(component, event) {
		component.set("v.requestedTemp", event.target.value);
	},

    sliderChangeHandler : function() {
		// Make call to connected thermostat here
	}
})