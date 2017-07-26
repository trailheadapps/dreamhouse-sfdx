({
	utteranceHandler : function(component, event, helper) {
        if (event.keyCode !== 13) {
            return;
        }
    	var utterance = event.target.value;
        var messages = component.get("v.messages");
        messages.push({author: "Me", messageText: utterance});
        event.target.value = "";
        component.set("v.messages", messages);
        helper.submit(component, utterance, component.get('v.session'), null, null, function(answer) {
            if (answer) {
                console.log(answer);
                component.set("v.session", answer.session);
                Array.prototype.push.apply(messages, answer.messages);
                component.set("v.messages", messages);
            }
        });
	},
    
    postbackButtonClickHandler : function(component, event, helper) {
    	var utterance = event.getSource().get("v.label");
		var messages = component.get("v.messages");
		messages.push({author: "Me", messageText: utterance});
        component.set("v.messages", messages);
        helper.submit(component, utterance, component.get('v.session'), null, null, function(answer) {
            if (answer) {
                console.log(answer);
                component.set("v.session", answer.session);
                Array.prototype.push.apply(messages, answer.messages);
                component.set("v.messages", messages);
            }
        });
    },
    
	uploadFile: function(component, event, helper) {
        var files = component.get("v.files");
        if (files && files.length > 0) {
	        var file = files[0][0];
            if (!file.type.match(/(image.*)/)) {
                return alert('Image file not supported');
            }
            var reader = new FileReader();
            reader.onloadend = function() {
                var dataURL = reader.result;
                var content = dataURL.match(/,(.*)$/)[1];
                var messages = component.get("v.messages");
                var utterance = component.find('utterance').getElement().value;
            	messages.push({author: "Me", messageText: "Uploading file " + file.name, imageURL: dataURL});
	        	component.set("v.messages", messages);
				helper.submit(component, utterance, component.get('v.session'), file.name, content, function(answer) {
                    if (answer) {
                        console.log(answer);
                        component.set("v.session", answer.session);
                        Array.prototype.push.apply(messages, answer.messages);
                        component.set("v.messages", messages);
                    }
                });
            };
            reader.readAsDataURL(file);
        }
	}
    
})