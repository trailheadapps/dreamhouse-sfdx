@isTest
public class SlackOpportunityPublisherTest {
    
    static testMethod void testPost() {
        Boolean success = true;
        try {
            Opportunity opp = new Opportunity(Name='test opportunity', StageName='Close Won', CloseDate=date.today());
            insert opp;
	        SlackOpportunityPublisher.postToSlack(new List<Id> { opp.Id });
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

}