({
   	recordChangeHandler : function(component, event) {
        var id = event.getParam("recordId");
        component.set("v.recordId", id);
        var service = component.find("service");
        service.reloadRecord();
	},
    
    editRecord : function(component, event, helper) {
        var recordId = component.get("v.recordId")
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": recordId
        });
        editRecordEvent.fire(); 
    }
    
})