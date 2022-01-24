({
    doInit: function (component, event, helper) {
        helper.getProperties(component);
    },

    onFilterChange: function (component, event, helper) {
        component.set('v.searchKey', event.getParam('searchKey'));
        component.set('v.minPrice', event.getParam('minPrice'));
        component.set('v.maxPrice', event.getParam('maxPrice'));
        component.set('v.numberBedrooms', event.getParam('numberBedrooms'));
        component.set('v.numberBathrooms', event.getParam('numberBathrooms'));
        helper.getProperties(component);
    },

    onFilterChange: function (component, event, helper) {
        component.set('v.searchKey', event.getParam('searchKey'));
        component.set('v.minPrice', event.getParam('minPrice'));
        component.set('v.maxPrice', event.getParam('maxPrice'));
        component.set('v.numberBedrooms', event.getParam('numberBedrooms'));
        component.set('v.numberBathrooms', event.getParam('numberBathrooms'));
        component.set('v.visualSearchKey', event.getParam('visualSearchKey'));
        helper.getProperties(component);
    },

    onPagePrevious: function (component, event, helper) {
        var pageNumber = component.get('v.pageNumber') || 1;
        pageNumber = pageNumber - 1;
        helper.getProperties(component, pageNumber);
    },

    onPageNext: function (component, event, helper) {
        var pageNumber = component.get('v.pageNumber') || 1;
        pageNumber = pageNumber + 1;
        helper.getProperties(component, pageNumber);
    }
});
