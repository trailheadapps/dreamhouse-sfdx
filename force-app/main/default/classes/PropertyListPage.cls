public class PropertyListPage {
    
    @AuraEnabled
    public Integer pageSize { get;set; }
    
    @AuraEnabled
    public Integer pageNumber { get;set; }
    
    @AuraEnabled
    public Integer total { get;set; }
    
    @AuraEnabled
    public List<Property__c> properties { get;set; }
    
}