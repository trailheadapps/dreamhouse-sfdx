({
    onChange: function (component, event, helper) {
        var utterance = event.getParam('value');
        var regex = /([A-Za-z0-9]*) bedrooms in ([A-Za-z]*)/i;
        var result = utterance.match(regex);
        console.log(result);
        if (result && result.length > 0) {
            var bedrooms = result[1];
            if (bedrooms == 'one') bedrooms = 1;
            if (bedrooms == 'two') bedrooms = 2;
            if (bedrooms == 'three') bedrooms = 3;
            if (bedrooms == 'four') bedrooms = 4;
            if (bedrooms == 'five') bedrooms = 5;
            if (bedrooms == 'six') bedrooms = 6;
            var filterChangeEvent = $A.get('e.c:PropertyFilterChange');
            filterChangeEvent.setParams({
                searchKey: result[2],
                numberBedrooms: bedrooms,
                minPrice: 0,
                maxPrice: 99999999,
                numberBathrooms: 0,
                visualSearchKey: ''
            });
            filterChangeEvent.fire();
        }
    }
});
