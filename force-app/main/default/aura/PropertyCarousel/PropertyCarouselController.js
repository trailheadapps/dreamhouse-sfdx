({
    onInit : function(component, event, helper) {
        helper.loadPictures(component);
    },
    
	onUploadFinished: function (component, event, helper) {
        helper.loadPictures(component);
    },
    
    /*
    When a new Property is selected (in another component), load the corresponding
    property record.
    */
    recordChangeHandler: function (component, event, helper) {
        component.set("v.recordId", event.getParam("recordId"));
        helper.loadPictures(component);
    },

})