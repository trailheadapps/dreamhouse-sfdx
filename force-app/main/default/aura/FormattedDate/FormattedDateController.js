({
	valueChangeHandler : function(component) {
        var value = component.get("v.value");
		var formattedValue = new Date(value).toLocaleString('en-US', {month: 'short', year: 'numeric', day: 'numeric'});
        component.set("v.formattedValue", formattedValue);
	}
})