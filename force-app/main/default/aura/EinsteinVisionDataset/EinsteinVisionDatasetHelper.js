({
	getModelsByDataset : function(component) {
        var action = component.get("c.getModelsByDataset"); 
        action.setParams({
            datasetId: component.get("v.dataset").id
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            if (state === 'ERROR') {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
            var models = JSON.parse(response.getReturnValue()).data;
            for (var i=0; i<models.length; i++) {
                console.log(models[i].progress);
                if (models[i].progress) {
	                models[i].progress = parseFloat(models[i].progress) * 100 + "%";
                    console.log(models[i].progress);
                } else {
                    console.log('n/a');
                }
            }
            component.set("v.models", models);
        });
        $A.enqueueAction(action); 
	}
})