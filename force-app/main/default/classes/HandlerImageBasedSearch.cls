public with sharing class HandlerImageBasedSearch implements BotHandler {

    private String modelId = 'VNAIIMX543MNUEKPW6UWAJPKKY';
    
    private String formatCurrency(Decimal i) {
        if (i == null) return '0';
        i = Decimal.valueOf(Math.roundToLong(i * 100)) / 100;
        String s = (i.setScale(2) + (i >= 0 ? 0.001 : -0.001)).format();
        return '$' + s.substring(0, s.length() - 1);
    }
    
	public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        
        List<EinsteinVisionController.Prediction> predictions = EinsteinVisionController.predict('', fileContent, modelId);
        List<BotRecord> records = new List<BotRecord>();
        for (EinsteinVisionController.Prediction p : predictions) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('House Type', p.label));
            fields.add(new BotField('Probability', '' + (p.probability * 100).round() +'%'));
            records.add(new BotRecord(fields));
        }
        
        BotMessage predictionMessage = new BotMessage('DreamBot', null, records);
        
        String key = '%' + predictions[0].label + '%';
        List<Property__c> properties = 
            [SELECT Id, Name, Beds__c, Baths__c, Tags__c, Price__c FROM Property__c
             WHERE tags__c LIKE :key
             ORDER BY Price__c
             LIMIT 5];
        List<BotRecord> propertyRecords = new List<BotRecord>();
        for (Property__c p : properties) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('Name', p.Name, '#/sObject/' + p.Id + '/view'));
            fields.add(new BotField('Bedrooms', '' + p.Beds__c));
            fields.add(new BotField('Category', '' + p.Tags__c));
            fields.add(new BotField('Price', '' + this.formatCurrency(p.Price__c)));
            propertyRecords.add(new BotRecord(fields));
        }
        BotMessage propertyMessage = new BotMessage('DreamBot', 'Here is a list of houses that look similar:', propertyRecords);
        
        BotResponse r = new BotResponse();
        
        r.messages = new BotMessage[] {predictionMessage, propertyMessage};
            
        return r;
        
    }
    
}