({
    onPriceRangeChange: function (component, event, helper) {
        component.set('v.minPrice', event.getParam('minValue'));
        component.set('v.maxPrice', event.getParam('maxValue'));
        helper.fireFilterChangeEvent(component);
    },

    onFilterChange: function (component, event, helper) {
        helper.fireFilterChangeEvent(component);
    },

    onPrediction: function (component, event, helper) {
        var predictions = event.getParam('predictions');
        if (predictions && predictions.length > 0) {
            component.set('v.visualSearchKey', predictions[0].label);
            helper.fireFilterChangeEvent(component);
        }
    },

    onReset: function (component, event, helper) {
        component.set('v.searchKey', '');
        component.set('v.minPrice', 200000);
        component.set('v.maxPrice', 1200000);
        component.set('v.numberBedrooms', 0);
        component.set('v.numberBathrooms', 0);
        component.set('v.visualSearchKey', '');
        var priceRange = component.find('priceRange');
        priceRange.setValues(200000, 1200000);
        helper.fireFilterChangeEvent(component);
    }
});
