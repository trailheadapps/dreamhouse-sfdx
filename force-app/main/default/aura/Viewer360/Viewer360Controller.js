({
    doInit : function(component) {
	},

    onMaximize : function(component) {
        component.set("v.fullScreen", true);
	},

    onMinimize : function(component) {
        component.set("v.fullScreen", false);
	},

	closeDialog : function(component) {
        component.set("v.fullScreen", false);
	},

  	onRecordUpdated : function(component, event) {
    }
})