({
    rerender: function (component) {
        var nodes = this.superRerender();
        if (!window.L) return nodes;
        var map = component.get("v.map");
         if (!map) {
        	var mapElement = component.find("map").getElement();
        	map = window.L.map(mapElement, {zoomControl: true}).setView([37.784173, -122.401557], 14);
        	window.L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                           {attribution: 'Tiles © Esri'}).addTo(map);
        	component.set("v.map", map);
        	var markers = new window.L.FeatureGroup();
            component.set("v.markers", markers);
        }
        return nodes;
    }
})