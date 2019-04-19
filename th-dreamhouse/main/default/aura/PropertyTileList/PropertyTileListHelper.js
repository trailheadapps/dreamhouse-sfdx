({
        getProperties: function (component, pageNumber) {
                var action = component.get("c.getPropertyListPage");
                var pageSize = component.get("v.pageSize");
                action.setParams({
                        "searchKey": component.get("v.searchKey"),
                        "minPrice": component.get("v.minPrice"),
                        "maxPrice": component.get("v.maxPrice"),
                        "numberBedrooms": component.get("v.numberBedrooms"),
                        "numberBathrooms": component.get("v.numberBathrooms"),
                        "visualSearchKey": component.get("v.visualSearchKey"),
                        "pageSize": pageSize,
                        "pageNumber": pageNumber || 1
                });
                action.setCallback(this, function (response) {
                        var page = response.getReturnValue();
                        console.log('Page %d loaded in %fms', page.pageNumber, performance.now() - startTime);
                        component.set("v.properties", page.properties);
                        component.set("v.pageNumber", page.pageNumber);
                        component.set("v.total", page.total);
                        component.set("v.pages", Math.ceil(page.total / pageSize));
                });
                var startTime = performance.now();
                $A.enqueueAction(action);
        }
})