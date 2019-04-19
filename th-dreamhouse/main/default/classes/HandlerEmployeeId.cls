public with sharing class HandlerEmployeeId implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        return new BotResponse(new BotMessage('Bot', 'Your employee id is 9854'));
    }
    
}