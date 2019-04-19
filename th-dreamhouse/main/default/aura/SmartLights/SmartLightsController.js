({
	onInit : function(component, event, helper) {
        helper.getLights(component, helper);
 	},

	powerChangeHandler : function(component, event, helper) {
        helper.setPower(component, event.currentTarget.dataset.id, event.currentTarget.checked);
	},

	brightnessChangeHandler : function(component, event, helper) {
        helper.setBrightness(component, event.currentTarget.dataset.id, event.currentTarget.value);
	}

})