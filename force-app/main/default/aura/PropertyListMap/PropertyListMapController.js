({
    onFilterChange: function (component, event, helper) {
        component.set('v.searchKey', event.getParam('searchKey'));
        component.set('v.minPrice', event.getParam('minPrice'));
        component.set('v.maxPrice', event.getParam('maxPrice'));
        component.set('v.numberBedrooms', event.getParam('numberBedrooms'));
        component.set('v.numberBathrooms', event.getParam('numberBathrooms'));
        component.set('v.visualSearchKey', event.getParam('visualSearchKey'));
        helper.getProperties(component);
    },

    onInit: function (component, event, helper) {
        helper.getProperties(component);
    },

    onJSLoaded: function (component) {
        component.set('v.jsLoaded', true);
    }
});
