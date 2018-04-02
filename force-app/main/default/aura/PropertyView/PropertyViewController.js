({
    onRecordChange: function (component, event) {
        if (component.get("v.recordId")) {
            var propertyService = component.find("propertyService");
            propertyService.reloadRecord();
        }
    },
})