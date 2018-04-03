({
    onInit: function (component, event, helper) {
        helper.loadPictures(component);
    },

    // onRecordChange: function (component, event, helper) {
    //     helper.loadPictures(component);
    // },

    onUploadFinished: function (component, event, helper) {
        helper.loadPictures(component);
        // var uploadedFiles = event.getParam("files");
        // var toastEvent = $A.get("e.force:showToast");
        // toastEvent.setParams({
        //     "title": "Success!",
        //     "message": "File " + uploadedFiles[0].name + " Uploaded successfully."
        // });
        // toastEvent.fire();
    }

})