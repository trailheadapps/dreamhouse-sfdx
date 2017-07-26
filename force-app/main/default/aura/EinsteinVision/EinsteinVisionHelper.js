({

    upload: function(component, file, base64Data) {
        var action = component.get("c.predict"); 
        var modelId = component.get("v.modelId"); 
        action.setParams({
            fileName: file.name,
            content: base64Data, 
            modelId: modelId
        });
        action.setCallback(this, function(a) {
            component.set("v.waiting", false);
            var state = a.getState();
            if (state === 'ERROR') {
                console.log(a.getError());
                alert("An error has occurred");
            }
            var result = a.getReturnValue();
            var predictions = [];
            if (result && result.length) {
                for (var i=0; i<result.length; i++) {
                    predictions.push({
                        label: result[i].label,
                        formattedProbability: '' + Math.round(result[i].probability * 100) + '%'
                    });
                }
	            component.set("v.predictions", predictions);
                var myEvent = $A.get("e.c:EinsteinVisionEvent");
                myEvent.setParams({
                    "predictions": result
                });
                myEvent.fire();
            }
        });
        component.set("v.predictions", null);
        component.set("v.waiting", true);
        $A.enqueueAction(action); 
    }

})