({
    onInit : function(component, event, helper) {
        var property = component.get("v.property");
        var action = component.get("c.getAtRiskProperties");
        action.setCallback(this, function(response){
            component.set("v.atRiskProperties", response.getReturnValue());
        });
        $A.enqueueAction(action);
    },

    optimize : function(component, event, helper) {
        var propertyId = event.getSource().get("v.name");
        component.set("v.fullScreen", true);
        var flow = component.find("flow");
        flow.startFlow("Optimize_Listing", [{name: 'recordId', type: 'String', value: propertyId}]);
    },

    flowStatusChange : function(component, event, helper) {
        if (event.getParam("status") === "FINISHED") {
            component.set("v.fullScreen", false);
        }
    }

})
