({
    rerender: function (component, helper) {
        this.superRerender();
        window.setTimeout(
    		$A.getCallback(function() {
                if (component.isValid()) {
                    var el = component.find("content").getElement();
				    el.scrollTop = el.scrollHeight;
                }
		    }),200);
	}
    
})