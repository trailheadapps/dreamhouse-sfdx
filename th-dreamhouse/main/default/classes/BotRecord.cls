public class BotRecord {

    @AuraEnabled 
    public List<BotField> fields { get;set; }
    
    public BotRecord(List<BotField> fields) {
        this.fields = fields;
    }

}