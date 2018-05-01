({
    hideSpinner: function(component) {
        var spinner = component.find('spinner');
        $A.util.removeClass(spinner, "slds-hide");
    },

    getRecordLocation: function(component) {
    	this.hideSpinner(component);

        var objectType = component.get("v.sObjectName");
        console.log(objectType);
        var searchTerm = component.find("searchTerm").get("v.value");
        if (!searchTerm) {
            searchTerm = component.get("v.defaultSearch");
        }
        var action;
        if (component.get("v.recordId")) {
            action = component.get("c.objectSelect");
            action.setParams({
                "recordId": component.get("v.recordId"),
                "objectType": objectType
            });
            console.log("action:\n" + JSON.stringify(action.getParams(), null, 4));
        } else {
            var location = component.get("v.location");
            action = component.get("c.getListByLatLon");
            action.setParams({
                "searchTerm": searchTerm,
                "latlon": location.coords.latitude + "," + location.coords.longitude
            });
        }
        action.setCallback(this, function(response) {
        	component.set("v.location", response.getReturnValue());
			var ys = component.find("yelpservice");
    		ys.set("v.address", component.get("v.location"));
    		ys.set("v.searchTerm", component.get("v.searchTerm"));
        });
        action.setStorable();
        $A.enqueueAction(action);
    },

	initializeLayout: function(component, event, helper) {
        if (component.get("v.recordId")) {
        	this.unfixMain(component);
            this.getRecordLocation(component, component.get("v.recordId"));
        } else {
        	this.fixScrollArea(component);
            this.hideSpinner(component);
            navigator.geolocation.getCurrentPosition(function(e) {
                component.set("v.location", e);
            }, function() {
                component.set("v.errorMessage", "Could not get your current geolocation.");
                var warning = component.find('warning');
                $A.util.removeClass(warning, 'slds-hide');
            });
        }
    },

    unfixMain: function(component) {
        $A.util.removeClass(component.find('main'), 'small');
		$A.util.addClass(component.find('main'), component.get("v.designHeight"));
    },

    fixScrollArea: function(component) {
        $A.util.removeClass(component.find('main'), 'small');
        $A.util.removeClass(component.find('main'), component.get("v.designHeight"));
        $A.util.addClass(component.find('main'), 'autoHeight');
        $A.util.removeClass(component.find('scrollableArea'), 'scroll-container');
        $A.util.removeClass(component.find('scrollableArea'), 'slds-scrollable--y');
    },

    handleBackButton: function(component) {
        var panelList = component.find("panelList");
        var panelDetails = component.find("panelDetails");
        $A.util.removeClass(panelList, 'panel--stageLeft');
        $A.util.addClass(panelList, 'panel--visible');
        $A.util.removeClass(panelDetails, 'panel--visible');
        $A.util.addClass(panelDetails, 'panel--stageRight');
    },

	doLayout: function(component, data) {
	    if (data.error) {
	        component.set("v.errorMessage", data.error);
	        var warning = component.find('warning');
	        $A.util.removeClass(warning, 'slds-hide');
	    } else if (data.resultList) {
	        component.set("v.staticLocation", data.locationUsed);
	        component.set("v.restaurantList", data.resultList);
	    }
        var spinner = component.find('spinner');
        $A.util.addClass(spinner, "slds-hide");
    },

    revealDetailsPane: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var recID = selectedItem.dataset.record;
        var data = component.get('v.restaurantList');
        var recordLoc = component.get("v.staticLocation");
        if (!recordLoc) {
            recordLoc = component.get("v.location");
        }

        var map = component.get("v.map");
        if (!map) {
            var mapElement = component.find("map").getElement();
            map = L.map(mapElement, { zoomControl: true }).setView([recordLoc.latitude, recordLoc.longitude], 14);
            L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', { attribution: 'Tiles © Esri', reuseTiles: true }).addTo(map);
            component.set("v.map", map);
            var orgLoc = L.marker([recordLoc.latitude, recordLoc.longitude]).addTo(map);
            var markers = new L.FeatureGroup();
            component.set("v.markers", markers);
        }

        var markers = component.get('v.markers');
        if (markers) {
            markers.clearLayers();
        }
        var bizLoc = L.marker([data[recID].location.latitude, data[recID].location.longitude]); 
        bizLoc.bindPopup("<b>" + data[recID].name + "</b>");
        markers.addLayer(bizLoc);
        map.addLayer(markers);
        

        map.panTo([data[recID].location.latitude, data[recID].location.longitude]);

        var panelList = component.find("panelList");
        var panelDetails = component.find("panelDetails");
        $A.util.removeClass(panelList, 'panel--visible');
        $A.util.addClass(panelList, 'panel--stageLeft');
        $A.util.removeClass(panelDetails, 'panel--stageRight');
        $A.util.addClass(panelDetails, 'panel--visible');
        component.set("v.itemName", data[recID].name);
        component.set("v.address", data[recID].address);
        component.set("v.city", data[recID].city);
        component.set("v.state", data[recID].state);
        component.set("v.phone", data[recID].phone);
        component.set("v.image", data[recID].image);
        component.set("v.review", data[recID].review);
    }
})