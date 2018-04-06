({

    submit: function(component, utterance, session, fileName, base64Data, callback) {
        var action = component.get("c.submit"); 
        action.setParams({
      		utterance: utterance,
            session: session,
            fileName: fileName,
            fileContent: base64Data
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
	            callback(a.getReturnValue());
            } else if (state === 'ERROR') {
	            var errors = a.getError();
                console.log(errors);
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            } else if (state === "INCOMPLETE") {
				console.log("Incomplete");
            }

        });
        $A.enqueueAction(action);
    }

})