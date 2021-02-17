public with sharing class HandlerPipeline implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {

        return new BotResponse(new BotMessage('Bot', 'Here is your pipeline:', 'https://s3-us-west-1.amazonaws.com/sfdc-demo/charts/pipeline.png'));
        
    }
    
}