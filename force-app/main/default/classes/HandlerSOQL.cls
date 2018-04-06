public with sharing class HandlerSOQL implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        
        SObject[] objects = Database.query(utterance);
        
        List<BotRecord> records = new List<BotRecord>();
        
        for (sObject o : objects) {
            List<BotField> fields = new List<BotField>();
            Map<String, Object> fieldMap = o.getPopulatedFieldsAsMap();
            for (String fieldName : fieldMap.keySet()) {
                String linkURL;
                if (fieldName == 'Id') {
                    linkURL = '#/sObject/' + o.Id + '/view';
                }
                fields.add(new BotField(fieldName, '' + fieldMap.get(fieldName), linkURL));
            }
            records.add(new BotRecord(fields));
        }
        return new BotResponse(new BotMessage('Bot', 'Here is the result of your query:', records));
        
    }
    
}