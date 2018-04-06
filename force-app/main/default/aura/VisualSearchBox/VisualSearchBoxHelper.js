({
    readFile: function(component, helper, file) {
        console.log('readfile: ' + new Date());
        
            if (!file.type.match(/(image.*)/)) {
                return alert('Image file not supported');
            }
            var reader = new FileReader();
            reader.onloadend = function() {
                console.log('readfile onloadend: ' + new Date());
                var dataURL = reader.result;
                component.set("v.pictureSrc", dataURL);
                helper.upload(component, file, dataURL.match(/,(.*)$/)[1]);
            };
            reader.readAsDataURL(file);
	},

    upload: function(component, file, base64Data) {
        console.log('upload: ' + new Date());
        var action = component.get("c.predict"); 
        var modelId = component.get("v.modelId"); 
        action.setParams({
            fileName: file.name,
            content: base64Data, 
            modelId: modelId
        });
        action.setCallback(this, function(a) {
            console.log('upload callback: ' + new Date());
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
                var predictionEvent = component.getEvent("onPrediction");
                predictionEvent.setParams({
                    "predictions": result
                });
                predictionEvent.fire();
            }
        });
        component.set("v.predictions", null);
        component.set("v.waiting", true);
        $A.enqueueAction(action); 
    }

})