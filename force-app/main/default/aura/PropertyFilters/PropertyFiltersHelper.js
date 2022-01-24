({
    fireFilterChangeEvent: function (component) {
        var filterChangeEvent = $A.get('e.c:PropertyFilterChange');
        filterChangeEvent.setParams({
            searchKey: component.get('v.searchKey'),
            minPrice: component.get('v.minPrice'),
            maxPrice: component.get('v.maxPrice'),
            numberBedrooms: component.get('v.numberBedrooms'),
            numberBathrooms: component.get('v.numberBathrooms'),
            visualSearchKey: component.get('v.visualSearchKey')
        });
        filterChangeEvent.fire();
    }
});
