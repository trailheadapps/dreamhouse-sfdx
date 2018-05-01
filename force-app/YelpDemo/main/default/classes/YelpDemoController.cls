public class YelpDemoController {    
    
    @AuraEnabled
    public static String objectSelect(String objectType, Id recordId) {
        if (objectType.toLowercase() == 'account') {
            return accountSelect(recordId);
        } else if (objectType.toLowercase() == 'contact') {
            return contactSelect(recordId);
        } else if (objectType.toLowercase() == 'property__c') {
            return propertySelect(recordId);
        } else {
            // This is an error....
            return null;
        }
    }

    public static String contactSelect (Id recordId) {
        Contact contact = [SELECT MailingStreet, MailingCity, MailingState FROM Contact WHERE Id=:recordId];
        String location = contact.MailingStreet + ',' + contact.MailingCity + ',' + contact.MailingState;
        return location;
    }
    
    public static String propertySelect (Id recordId) {
        Property__c property = [SELECT Address__c, City__c, State__c FROM Property__c WHERE Id=:recordId];
        String location = property.Address__c + ',' + property.City__c + ',' + property.State__c;
        return location;
    }

    public static String accountSelect (Id recordId) {
        Account account = [SELECT BillingStreet, BillingCity, BillingState FROM Account WHERE Id=:recordId];
        String location = account.BillingStreet + ',' + account.BillingCity + ',' + account.BillingState;
        return location;
    }
}