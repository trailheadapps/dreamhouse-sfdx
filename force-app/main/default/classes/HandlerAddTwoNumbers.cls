public with sharing class HandlerAddTwoNumbers implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        if (session == null) {
            session = new Map<String, String>();
            session.put('nextCommand', 'HandlerAddTwoNumbers');
            session.put('step', 'askFirstNumber');
            return new BotResponse(new BotMessage('Bot', 'What\'s the first number?'), session);
        }
        String step = session.get('step');
        if (step == 'askFirstNumber') {
            session.put('firstNumber', utterance);
            session.put('nextCommand', 'HandlerAddTwoNumbers');
            session.put('step', 'askSecondNumber');
            return new BotResponse(new BotMessage('Bot', 'What\'s the second number?'), session);
        } else {
			Integer firstNumber = Integer.valueof(session.get('firstNumber'));
        	Integer secondNumber = Integer.valueof(utterance);
        	Integer total = firstNumber + secondNumber;
        	BotMessage message = new BotMessage('Bot', '' + firstNumber + ' + ' + secondNumber + ' = ' + total);
        	return new BotResponse(message);
        }
        
    }
    
}