trigger PushNotificationTrigger on Property__c (after update) {
    
    /*
    for (Property__c property : Trigger.New) {
        
        if (property.Price__c != Trigger.oldMap.get(property.Id).Price__c) {
            Messaging.PushNotification msg = new Messaging.PushNotification();
            String text = property.Name + '. New Price: $' + property.Price__c.setScale(0).format();
            Map<String, Object> payload = Messaging.PushNotificationPayload.apple(text, '', null, null);
            msg.setPayload(payload);
            Set<String> users = new Set<String>();
            users.add(UserInfo.getUserId());
            msg.send('DreamHouzz', users);
        } 
        
    }
	*/

}