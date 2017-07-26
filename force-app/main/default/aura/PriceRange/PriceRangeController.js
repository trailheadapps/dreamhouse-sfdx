({
    jsLoaded: function(component, event, helper) {
        var min = parseInt(component.get("v.min"), 10);
        var max = parseInt(component.get("v.max"), 10);
        var step = parseInt(component.get("v.step"), 10);
        
        var slider = component.find('slider').getElement();
        noUiSlider.create(slider, {
            start: [min, max],
            connect: true,
            tooltips: true,
            format: {
                to: function ( value ) {
                    if (value >= 1000000) {
                        return (Math.round(value / 10000) / 100) + 'M';
                    } else if (value > 100000) {
                        return Math.round(value / 1000) + 'K';
                    } else {
	                    return Math.round(value);
                    }
                },
                from: function ( value ) {
                    return value;
                }
            },
            step: step,
            range: {
                'min': min,
                'max': max
            }
        });
        
		slider.noUiSlider.on('change', $A.getCallback(function(range) {
            
            function convert(value) {
                if (value.indexOf('M') > 0) {
                    var v = value.replace('M', '');
                    return v * 1000000;
                } else {
                    return value.replace('K', '000');
                }
            }

            var myEvent = $A.get("e.c:RangeChange");
        	myEvent.setParams({
            	"minValue": convert(range[0]),
            	"maxValue": convert(range[1])
            });
			myEvent.fire();
        }));
    }
})