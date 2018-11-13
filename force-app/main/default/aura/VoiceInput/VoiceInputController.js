({
    onInit: function (component, event, helper) {
        component.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        component.SpeechGrammarList = window.SpeechGrammarList || window.webkitSpeechGrammarList;
        component.SpeechRecognitionEvent = window.SpeechRecognitionEvent || window.webkitSpeechRecognitionEvent;
    },

    onTalk: function (component, event, helper) {

        component.set("v.talking", true);

        //var grammar = '#JSGF V1.0; grammar numbers; public number = 1 | 2 | 3 | 4 | 5 ';
        var recognition = new component.SpeechRecognition();
        var speechRecognitionList = new component.SpeechGrammarList();
        //speechRecognitionList.addFromString(grammar, 1);
        recognition.grammars = speechRecognitionList;
        recognition.lang = 'en-US';
        recognition.interimResults = false;
        recognition.maxAlternatives = 1;

        recognition.start();

        recognition.onresult = function (event) {
            component.set("v.talking", false);
            var utterance = event.results[0][0].transcript;
            component.set("v.utterance", utterance);
            component.find('utterance').getElement().value = utterance;
            helper.fireChangeEvent(component);
            console.log('Confidence: ' + event.results[0][0].confidence);
        }

        recognition.onspeechend = function () {
            recognition.stop();
        }

        recognition.onerror = function (event) {
            component.set("v.talking", false);
            component.set("v.result", event.error);
        }

        recognition.onaudiostart = function (event) {
            //Fired when the user agent has started to capture audio.
            console.log('SpeechRecognition.onaudiostart');
        }

        recognition.onaudioend = function (event) {
            //Fired when the user agent has finished capturing audio.
            console.log('SpeechRecognition.onaudioend');
        }

        recognition.onend = function (event) {
            //Fired when the speech recognition service has disconnected.
            console.log('SpeechRecognition.onend');
        }

        recognition.onnomatch = function (event) {
            //Fired when the speech recognition service returns a final result with no significant recognition. This may involve some degree of recognition, which doesn't meet or exceed the confidence threshold.
            console.log('SpeechRecognition.onnomatch');
        }

        recognition.onsoundstart = function (event) {
            //Fired when any sound � recognisable speech or not � has been detected.
            console.log('SpeechRecognition.onsoundstart');
        }

        recognition.onsoundend = function (event) {
            //Fired when any sound � recognisable speech or not � has stopped being detected.
            console.log('SpeechRecognition.onsoundend');
        }

        recognition.onspeechstart = function (event) {
            //Fired when sound that is recognised by the speech recognition service as speech has been detected.
            console.log('SpeechRecognition.onspeechstart');
        }
        recognition.onstart = function (event) {
            //Fired when the speech recognition service has begun listening to incoming audio with intent to recognize grammars associated with the current SpeechRecognition.
            console.log('SpeechRecognition.onstart');
        }

    },

    onKeyPress : function(component, event, helper) {
        if (event.keyCode !== 13) {
            return;
        }
        component.set("v.utterance", event.target.value);
        helper.fireChangeEvent(component);
    },
    
    clear : function(component) {
        component.find('utterance').getElement().value = '';
    }

})