({
	getDatasets : function(component) {
        var action = component.get("c.getDatasets"); 
        action.setCallback(this, function(response) {
            component.set("v.waiting", false);
            var state = response.getState();
            console.log(state);
            if (state === 'ERROR') {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        return alert(errors[0].message);
                    }
                } else {
                    return console.log("Unknown error");
                }
            }
            var result = response.getReturnValue();
            component.set("v.datasets", JSON.parse(result).data);
        });
        component.set("v.waiting", true);
        $A.enqueueAction(action); 
	}
})