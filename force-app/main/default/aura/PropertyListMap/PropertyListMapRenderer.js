({
    rerender: function (component) {

        var nodes = this.superRerender();

        // If the Leaflet library is not yet loaded, we can't draw the map: return
        if (!window.L) {
            return nodes;
        }

        // Draw the map if it hasn't been drawn yet
	    if (!component.map) {
            var mapElement = component.find("map").getElement();
            component.map = L.map(mapElement, {zoomControl: true}).setView([42.356045, -71.085650], 13);
            component.map.scrollWheelZoom.disable();
            window.L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', {attribution: 'Tiles © Esri'}).addTo(component.map);
	    }

		var center = component.get('v.center');

        if (center && center.lat && center.long) {
            component.map.setView(center);
        }

        if (component.layerGroup) {
            component.map.removeLayer(component.layerGroup)
        }

        var properties = component.get("v.properties");
        var markers = [];
        properties.forEach(function(property) {
            var latLng = [property.Location__Latitude__s, property.Location__Longitude__s];
            var myIcon = L.divIcon({
                className: 'my-div-icon',
                html: '<svg width="28" height="28" viewBox="0 0 100 100"><g><path fill="#235493" d="m78.8 51.2h-6.3v27.5c0 0.8-0.5 1.2-1.3 1.2h-12.4c-0.8 0-1.3-0.5-1.3-1.2v-21.2h-15v21.2c0 0.8-0.5 1.2-1.3 1.2h-12.4c-0.8 0-1.3-0.5-1.3-1.2v-27.5h-6.3c-0.5 0-1-0.2-1.1-0.8-0.3-0.5-0.1-1 0.3-1.4l28.8-28.8c0.5-0.5 1.4-0.5 1.8 0l28.8 28.8c0.4 0.4 0.4 0.9 0.3 1.4s-0.8 0.8-1.3 0.8z"></path></g>'
            });
            var marker = window.L.marker(latLng, {icon: myIcon});
            marker.propertyId = property.Id;
            marker.on("click", function(event) {
                var selectEvent = $A.get("e.ltng:selectSObject");
                selectEvent.setParams({"recordId": event.target.propertyId, channel: "Properties"});
                selectEvent.fire();
            });
            markers.push(marker);
        });

        component.layerGroup = L.layerGroup(markers);
        component.layerGroup.addTo(component.map);

        return nodes;

    }
})