public with sharing class HandlerFindPropertiesByBedrooms implements BotHandler {

    private String formatCurrency(Decimal i) {
        if (i == null) return '0.00';
        i = Decimal.valueOf(Math.roundToLong(i * 100)) / 100;
        String s = (i.setScale(2) + (i >= 0 ? 0.001 : -0.001)).format();
        return s.substring(0, s.length() - 1);
    }
    
	public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        if (params[0] == 'one') params[0] = '1';
        if (params[0] == 'two') params[0] = '2';
        if (params[0] == 'three') params[0] = '3';
        if (params[0] == 'four') params[0] = '4';
        if (params[0] == 'five') params[0] = '5';
        if (params[0] == 'six') params[0] = '6';
        List<Property__c> properties = 
            [SELECT Id, Name, Beds__c, Baths__c, Price__c FROM Property__c
             WHERE City__c = :params[1] AND 
             Beds__c = :Decimal.valueOf(params[0])
             ORDER BY Price__c
             LIMIT 10];
        List<BotRecord> records = new List<BotRecord>();
        for (Property__c p : properties) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('Name', p.Name, '/lightning/r/Property__c/' + p.Id + '/view'));
            fields.add(new BotField('Bedrooms', '' + p.Beds__c));
            fields.add(new BotField('Baths', '' + p.Baths__c));
            fields.add(new BotField('Price', '' + this.formatCurrency(p.Price__c)));
            records.add(new BotRecord(fields));
        }
        return new BotResponse(new BotMessage('Bot', 'Here is a list of ' + params[0] + ' bedrooms in ' + params[1] + ':', records));
    }
    
}