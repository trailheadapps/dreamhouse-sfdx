({
    handlePriceChange : function(component, event, helper) {
        console.log(component.get("v.price"));
        var price = component.get("v.price");
        var left = 270;
        if (price>605000) {
            left = 270;
        } else if (price>600000) {
            left = 240;
        } else if (price>590000) {
            left = 210;
        } else if (price>580000) {
            left = 180;
        // } else if (price>1100) {
        //     left = 150;
        } else if (price>570000) {
            left = 120;
        } else {
            left = 30;
        }
        component.find("current").getElement().style.left = left + "px";
    }
})