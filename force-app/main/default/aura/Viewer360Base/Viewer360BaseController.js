({
    onPlay: function(component) {
        component.set("v.isPlaying", true);
        var iframe = component.find('iframe').getElement();
        iframe.src = $A.get('$Resource.three') + '/index.html';
    },

    onStop: function(component) {
        component.set("v.isPlaying", false);
        var iframe = component.find('iframe').getElement();
        iframe.src = $A.get('$Resource.three') + '/empty.html';
    },

    onMaximize: function(component) {
        var viewerEvent = component.getEvent("onmaximize");
        viewerEvent.fire();
    },

    onMinimize: function(component) {
        var viewerEvent = component.getEvent("onminimize");
        viewerEvent.fire();
    },

})