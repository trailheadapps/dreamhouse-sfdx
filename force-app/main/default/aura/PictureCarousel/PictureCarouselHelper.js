({
    setSlideWidth: function (component) {
        var slideWidth = component.find("gallery").getElement().offsetWidth;
        component.set("v.slideWidth", slideWidth);
    }
})