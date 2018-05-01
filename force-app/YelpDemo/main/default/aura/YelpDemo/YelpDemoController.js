({
 	renderYelpData: function(component, event, helper) {
 		helper.doLayout(component, event.getParams());
 	},

	doInit: function(component, event, helper) {
		helper.initializeLayout(component, event, helper);
    },

    getBrowserLocation: function(component, event, helper) {
    	navigator.geolocation.getCurrentPosition(function(e) {
            component.set("v.latlon", e.coords.latitude + ',' + e.coords.longitude);
            helper.getYelpData(component);
        },
        function() {
            component.set("v.errorMessage", "Could not get your current geolocation.");
            var warning = component.find('warning');
            $A.util.removeClass(warning, 'slds-hide');
        });
    },

    updateSearch: function(component, event, helper) {
    	helper.getRecordLocation(component);
    },

    backButton: function(component, event, helper) {
    	helper.handleBackButton(component);
    },

     showDetails: function(component, event, helper) {
         helper.revealDetailsPane(component, event, helper);
     },

})