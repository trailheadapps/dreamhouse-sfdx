({
    getProperties: function (component) {
        var action = component.get('c.getPropertyList');
        action.setParams({
            searchKey: component.get('v.searchKey'),
            minPrice: component.get('v.minPrice'),
            maxPrice: component.get('v.maxPrice'),
            numberBedrooms: component.get('v.numberBedrooms'),
            numberBathrooms: component.get('v.numberBathrooms'),
            visualSearchKey: component.get('v.visualSearchKey')
        });
        action.setCallback(this, function (response) {
            var properties = response.getReturnValue();
            component.set('v.properties', properties);
        });
        $A.enqueueAction(action);
    }
});
