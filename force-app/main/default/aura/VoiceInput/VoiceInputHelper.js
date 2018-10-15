({
    fireChangeEvent : function(component) {
        var voiceInputChange = component.getEvent("onchange");
        voiceInputChange.setParams({value: component.get("v.utterance")});
        voiceInputChange.fire();
        component.set("v.utterance", "");
        var utteranceEl = component.find("utterance").getElement();
        utteranceEl.value = "";
        utteranceEl.placeholder = "";
    }
})