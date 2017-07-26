@isTest
public class RejectDuplicateFavoriteTest {

    public static String getUserNamePrefix(){
        return UserInfo.getOrganizationId() + System.now().millisecond();
    }
    
    public static User getTestUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        return new User(Alias='testuser', Email='test@user.com', 
                        EmailEncodingKey='UTF-8', LastName='test', LanguageLocaleKey='en_US', 
                        LocaleSidKey='en_US', ProfileId = p.Id, 
                        TimeZoneSidKey='America/Los_Angeles', UserName=getUserNamePrefix() + 'test@test.com');
    }

    static testMethod void acceptNonDuplicate() {
        Boolean success = true;
        try {
            Property__c p = new Property__c();
            insert p;
            User u = getTestUser();
            insert u;
            Favorite__c f1 = new Favorite__c(property__c=p.Id, user__c=u.Id);
			insert f1;
        } catch (Exception e) {
            System.debug(e);
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void rejectDuplicate() {
        Boolean success = true;
        try {
            Property__c p = new Property__c();
            insert p;
            User u = getTestUser();
            insert u;
            Favorite__c f1 = new Favorite__c(property__c=p.Id, user__c=u.Id);
			insert f1;
            Favorite__c f2 = new Favorite__c(property__c=p.Id, user__c=u.Id);
			insert f2;
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(!success);
        }
    }
    
}