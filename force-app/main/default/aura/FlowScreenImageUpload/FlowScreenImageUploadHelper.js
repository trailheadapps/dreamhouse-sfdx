({
    loadPictures : function(component) {
        var propertyId = component.get("v.recordId");
        if (!propertyId) {
            return;
        }
        component.set("v.files", []);
        var action = component.get("c.getPictures");
        action.setParams({
            "propertyId": propertyId,
        });
        action.setCallback(this, function (response) {
            var files = component.get("v.files");
            var newFiles = response.getReturnValue();
            if (!newFiles) {
                return;
            }
            if (!files) {
                files = [];
            } else {
                for (var i=files.length;i<newFiles.length; i++) {
                    console.log(newFiles[i]);
                    files.push(newFiles[i]);
                }
            }
            component.set("v.files", files);
        });
        $A.enqueueAction(action);
    }
})