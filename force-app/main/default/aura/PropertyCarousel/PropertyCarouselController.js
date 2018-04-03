({
    onInit : function(component, event, helper) {
        helper.loadPictures(component);
    },
    
	onUploadFinished: function (component, event, helper) {
        helper.loadPictures(component);
    },
    
    recordChangeHandler: function (component, event, helper) {
        component.set("v.recordId", event.getParam("recordId"));
        helper.loadPictures(component);
    },

})