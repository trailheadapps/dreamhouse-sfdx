({
    afterRender: function (component, helper) {
        this.superAfterRender();
		helper.setSlideWidth(component, helper);
    }
})