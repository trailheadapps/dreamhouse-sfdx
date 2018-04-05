public class HandlerFindProperties implements BotHandler {

    private String formatCurrency(Decimal i) {
        if (i == null) return '0.00';
        i = Decimal.valueOf(Math.roundToLong(i * 100)) / 100;
        String s = (i.setScale(2) + (i >= 0 ? 0.001 : -0.001)).format();
        return s.substring(0, s.length() - 1);
    }
    
	public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        if (session == null) {
            BotMessage message = new BotMessage('Bot', 'What City?');
            session = new Map<String, String>();
            session.put('nextCommand', 'HandlerFindProperties');
            session.put('step', 'city');
            return new BotResponse(message, session);
        }
		String step = session.get('step');
        if (step == 'city') {
            session.put('city', utterance);
			List<BotMessageButton> buttons = new List<BotMessageButton>();
            buttons.add(new BotMessageButton('Single Family', 'Single Family'));
            buttons.add(new BotMessageButton('Condominium', 'Condominium'));
            BotMessage message = new BotMessage('Bot', 'What type of property?', buttons);
            session.put('nextCommand', 'HandlerFindProperties');
            session.put('step', 'type');
            return new BotResponse(message, session);
        } else if (step == 'type') {
            session.put('type', utterance);
            BotMessage message = new BotMessage('Bot', 'Price range from?');
            session.put('nextCommand', 'HandlerFindProperties');
            session.put('step', 'minPrice');
            return new BotResponse(message, session);
        } else if (step == 'minPrice') {
            session.put('minPrice', utterance);
            BotMessage message = new BotMessage('Bot', 'Price range to?');
            session.put('nextCommand', 'HandlerFindProperties');
            session.put('step', 'maxPrice');
            return new BotResponse(message, session);
        } else if (step == 'maxPrice') {
            session.put('maxPrice', utterance);
            String city = session.get('city');
            Decimal minPrice = Decimal.valueOf(session.get('minPrice'));
            Decimal maxPrice = Decimal.valueOf(session.get('maxPrice'));
            List<Property__c> properties = 
                [SELECT Id, Name, Beds__c, Baths__c, Price__c FROM Property__c
                 WHERE City__c = :city AND 
                 Price__c >= :minPrice AND
                 Price__c <= :maxPrice
                 ORDER BY Price__c
                 LIMIT 5];
            
            List<BotRecord> records = new List<BotRecord>();
            
            for (Property__c p : properties) {
                List<BotField> fields = new List<BotField>();
                fields.add(new BotField('Name', p.Name, '#/sObject/' + p.Id + '/view'));
                fields.add(new BotField('Bedrooms', '' + p.Beds__c));
                fields.add(new BotField('Baths', '' + p.Baths__c));
                fields.add(new BotField('Price', '' + this.formatCurrency(p.Price__c)));
                records.add(new BotRecord(fields));
            }
            return new BotResponse(new BotMessage('Bot', 'Here is a list of properties in ' + city + ' between ' + this.formatCurrency(minPrice) + ' and ' + this.formatCurrency(maxPrice) + ': ', records));
        } else {
            return new BotResponse(new BotMessage('Bot', 'Sorry, I don\'t know how to handle that'));
        }
    }
    
}