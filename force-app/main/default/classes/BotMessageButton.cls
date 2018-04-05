public class BotMessageButton {

    @AuraEnabled public String label { get;set; }
    @AuraEnabled public String value { get;set; }
    
    public BotMessageButton(String label, String value) {
        this.label = label;
        this.value = value;
    }
    
}