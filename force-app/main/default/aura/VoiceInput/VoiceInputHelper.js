({
    fireChangeEvent: function (component) {
        var voiceInputChange = component.getEvent('onchange');
        voiceInputChange.setParams({ value: component.get('v.utterance') });
        voiceInputChange.fire();
    }
});
