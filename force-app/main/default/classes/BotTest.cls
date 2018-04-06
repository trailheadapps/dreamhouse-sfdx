@isTest
public class BotTest {
    
    static testMethod void testBotController() {
		Bot_Command__c bc = new Bot_Command__c(Sample_Utterance__c='help lightning', apex_class__c='HandlerHelpTopic', pattern__c='help (.*)');
        insert bc;
        BotResponse response = BotController.submit('help lightning', null, null, null);
        Map<String, String> session = response.session;
        response = BotController.submit('Developer', session, null, null);
        System.assert(response.messages[0].items.size() > 0);
    }

    static testMethod void testHello() {
        BotHandler handler = new HandlerHello();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages[0].messageText == 'Hi there!');
    }

    static testMethod void testAddTwoNumbers() {
        BotHandler handler = new HandlerAddTwoNumbers();
        BotResponse response = handler.handle('', null, null, null, null);
        Map<String, String> session = response.session;
        response = handler.handle('1', null, session, null, null);
        session = response.session;
        response = handler.handle('2', null, session, null, null);
        System.assert(response.messages[0].messageText == '1 + 2 = 3');
    }
    
    static testMethod void testCostCenter() {
        BotHandler handler = new HandlerCostCenter();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages[0].messageText == 'Your cost center is 21852');
    }
    
    static testMethod void testEmployeeId() {
        BotHandler handler = new HandlerEmployeeId();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages[0].messageText == 'Your employee id is 9854');
    }

    static testMethod void testFindAccount() {
		Account a = new Account(Name='TestAccount');
		insert a;
        BotHandler handler = new HandlerFindAccount();
        BotResponse response = handler.handle('', new String[]{'Test'}, null, null, null);
        System.assert(response.messages[0].records.size() == 1);
    }
    
    static testMethod void testFindContact() {
		Contact c = new Contact(LastName='TestContact');
        insert c;
        BotHandler handler = new HandlerFindContact();
        BotResponse response = handler.handle('', new String[]{'Test'}, null, null, null);
        System.assert(response.messages[0].records.size() == 1);
    }
    
	static testMethod void testHelp() {
		Bot_Command__c bc = new Bot_Command__c(Sample_Utterance__c='Hello', apex_class__c='HelloHandler', pattern__c='Hello');
        insert bc;
        BotHandler handler = new HandlerHelp();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages[0].items.size() == 1);
    }
    
	static testMethod void testHelpTopic() {
        BotHandler handler = new HandlerHelpTopic();
        BotResponse response = handler.handle('', null, null, null, null);
        Map<String, String> session = response.session;
		handler.handle('User', null, session, null, null);
        
        response = handler.handle('', null, null, null, null);
        session = response.session;
		response = handler.handle('Admin', null, session, null, null);

        response = handler.handle('', null, null, null, null);
        session = response.session;
		response = handler.handle('Developer', null, session, null, null);

        System.assert(response.messages[0].items.size() > 0);
    }
    
	static testMethod void testMyOpenCases() {
		Case c = new Case(Subject='TestCase');
		insert c;
        BotHandler handler = new HandlerMyOpenCases();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages[0].records.size() == 1);
    }

	static testMethod void testTopOpportunities() {
		Account a = new Account(Name='TestAccount');
		insert a;
		Opportunity o = new Opportunity(Name='TestOpportunity', AccountId=a.id, StageName='Prospecting', CloseDate=System.today().addMonths(1));
		insert o;
        BotHandler handler = new HandlerTopOpportunities();
        BotResponse response = handler.handle('', new String[]{'3'}, null, null, null);
        System.assert(response.messages[0].records.size() == 1);
    }

	static testMethod void testTravelApproval() {
        BotHandler handler = new HandlerTravelApproval();
        BotResponse response = handler.handle('', null, null, null, null);
        Map<String, String> session = response.session;
		handler.handle('Boston', null, session, null, null);
		handler.handle('Customer Facing', null, session, null, null);
		handler.handle('02/23/2017', null, session, null, null);
		handler.handle('1000', null, session, null, null);
		handler.handle('1000', null, session, null, null);
        System.assert(response.messages[0].messageText.length() > 0);
    }

	static testMethod void testPipeline() {
        BotHandler handler = new HandlerPipeline();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages[0].imageURL != null);
    }

	static testMethod void testQuarter() {
        BotHandler handler = new HandlerQuarter();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages[0].imageURL != null);
    }

    static testMethod void testNext() {
		Account a = new Account(Name='TestAccount');
		insert a;
		Opportunity o = new Opportunity(Name='TestOpportunity', AccountId=a.id, StageName='Prospecting', CloseDate=System.today().addMonths(1));
		insert o;
		Case c = new Case(Subject='TestCase', Priority='High');
		insert c;
        BotHandler handler = new HandlerNext();
        BotResponse response = handler.handle('', null, null, null, null);
        System.assert(response.messages.size() > 1);
    }

    static testMethod void testSOQL() {
		Account a = new Account(Name='TestAccount');
		insert a;
        BotHandler handler = new HandlerSOQL();
        BotResponse response = handler.handle('select id from account', null, null, null, null);
        System.assert(response.messages[0].records.size() == 1);
    }
    
    static testMethod void testFindPropertiesByBedrooms() {
        Property__c p = new Property__c(Name='TestProperty', Beds__c=3, City__c='Boston');
        insert p;
        BotHandler handler = new HandlerFindPropertiesByBedrooms();
        BotResponse response = handler.handle('', new String[]{'3', 'Boston'}, null, null, null);
        System.assert(response.messages[0].records.size() == 1);
    }

    static testMethod void testFindProperties() {
        Property__c p = new Property__c(Name='TestProperty', Price__c=450000, City__c='Boston');
        insert p;
        BotHandler handler = new HandlerFindProperties();
        Map<String, String> session = handler.handle('', null, null, null, null).session;
        session = handler.handle('Boston', null, session, null, null).session;
        session = handler.handle('Single Family', null, session, null, null).session;
        session = handler.handle('400000', null, session, null, null).session;
        BotResponse response = handler.handle('500000', null, session, null, null);
        System.assert(response.messages[0].records.size() == 1);
    }

}