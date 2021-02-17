public with sharing class HandlerQuarter implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {

        return new BotResponse(new BotMessage('Bot', 'Your quarter so far:', 'https://s3-us-west-1.amazonaws.com/sfdc-demo/charts/quarter2.png'));
        
    }
    
}