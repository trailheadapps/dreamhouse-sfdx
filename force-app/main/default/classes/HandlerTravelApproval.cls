public class HandlerTravelApproval implements BotHandler {

	public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        if (session == null) {
            BotMessage message = new BotMessage('Bot', 'Where are you going?');
            session = new Map<String, String>();
            session.put('nextCommand', 'HandlerTravelApproval');
            session.put('step', 'destination');
            return new BotResponse(message, session);
        }
		String step = session.get('step');
        if (step == 'destination') {
            session.put('destination', utterance);
			List<BotMessageButton> buttons = new List<BotMessageButton>();
            buttons.add(new BotMessageButton('Customer Facing', 'Customer Facing'));
            buttons.add(new BotMessageButton('Internal Meetings', 'Internal Meetings'));
            buttons.add(new BotMessageButton('Billable Work', 'Billable Work'));
            BotMessage message = new BotMessage('Bot', 'What\'s the reason for the trip?', buttons);
            session.put('nextCommand', 'HandlerTravelApproval');
            session.put('step', 'reason');
            return new BotResponse(message, session);
        } else if (step == 'reason') {
            session.put('reason', utterance);
            BotMessage message = new BotMessage('Bot', 'When are you leaving?');
            session.put('nextCommand', 'HandlerTravelApproval');
            session.put('step', 'travelDate');
            return new BotResponse(message, session);
        } else if (step == 'travelDate') {
            session.put('travelDate', utterance);
            BotMessage message = new BotMessage('Bot', 'What\'s the estimated airfare cost?');
            session.put('nextCommand', 'HandlerTravelApproval');
            session.put('step', 'airfare');
            return new BotResponse(message, session);
        } else if (step == 'airfare') {
            session.put('airfare', utterance);
            BotMessage message = new BotMessage(' Bot', 'What\'s the estimated hotel cost?');
            session.put('nextCommand', 'HandlerTravelApproval');
            session.put('step', 'hotel');
            return new BotResponse(message, session);
        }
        List<Botrecord> records = new List<BotRecord>();
        List<BotField> fields = new List<BotField>();
        fields.add(new BotField('Destination', session.get('destination')));
        fields.add(new BotField('Reason', session.get('reason')));
        fields.add(new BotField('Travel Date', session.get('travelDate')));
        fields.add(new BotField('Airfare', session.get('airfare')));
        fields.add(new BotField('Hotel', utterance));
        records.add(new BotRecord(fields));
		return new BotResponse(new BotMessage('Bot', 'OK, I submitted the following travel approval request on your behalf:', records));

    }

    
}