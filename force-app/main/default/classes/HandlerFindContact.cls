public with sharing class HandlerFindContact implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        String key = '%' + params[0] + '%';
        List<Contact> contacts = 
            [SELECT Id, Name, MobilePhone FROM Contact
             WHERE Name LIKE :key
             ORDER BY Name
             LIMIT 5];
        
        List<BotRecord> records = new List<BotRecord>();
        
        for (Contact c : contacts) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('Name', c.Name, '#/sObject/' + c.Id + '/view'));
            fields.add(new BotField('Phone', c.MobilePhone, 'tel:' + c.MobilePhone));
            records.add(new BotRecord(fields));
        }
        return new BotResponse(new BotMessage('Bot', 'Here is a list of contacts matching "' + params[0] + '":', records));
        
    }
    
}