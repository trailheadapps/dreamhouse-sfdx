({
    onInit: function (component, event, helper) {
        helper.loadPictures(component);
    },

    // onRecordChange: function (component, event, helper) {
    //     helper.loadPictures(component);
    // },

    onUploadFinished: function (component, event, helper) {
        helper.loadPictures(component);
    }

})