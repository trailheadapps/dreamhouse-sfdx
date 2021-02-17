public class BotResponse {

    @AuraEnabled public List<BotMessage> messages { get; set; }
    @AuraEnabled public Map<String, String> session { get; set; }
    
    public BotResponse() {
    }

    public BotResponse(BotMessage[] messages) {
        this.messages = messages;
    }

    public BotResponse(List<BotMessage> messages, Map<String, String> session) {
        this.messages = messages;
        this.session = session;
    }

    /**
     * Convenience constructor to create a response with a single message
     */
    public BotResponse(BotMessage message) {
        this.messages = new BotMessage[]{message};
    }

    /**
     * Convenience constructor to create a response with a single message
     */
    public BotResponse(BotMessage message, Map<String, String> session) {
        this.messages = new BotMessage[]{message};
        this.session = session;
    }
    
}