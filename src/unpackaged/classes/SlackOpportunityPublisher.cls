public with sharing class SlackOpportunityPublisher {
    
    private static final String slackURL = Dreamhouse_Settings__c.getOrgDefaults().Slack_Opportunity_Webhook_URL__c;
    
    @InvocableMethod(label='Post to Slack')
    public static void postToSlack(List<Id> opportunityId) {
        Id oppId = opportunityId[0]; // If bulk, only post first to avoid overloading Slack channel
        Opportunity opportunity = [SELECT Name, StageName from Opportunity WHERE Id=:oppId];
		Map<String,Object> msg = new Map<String,Object>();
		msg.put('text', 'The following opportunity has changed:\n' + opportunity.Name + '\nNew Stage: *' 
                + opportunity.StageName + '*');
		msg.put('mrkdwn', true);
        String body = JSON.serialize(msg);    
        System.enqueueJob(new QueueableSlackCall(slackURL, 'POST', body));
    }
    
    public class QueueableSlackCall implements System.Queueable, Database.AllowsCallouts {
        
        private final String url;
        private final String method;
        private final String body;
        
        public QueueableSlackCall(String url, String method, String body) {
            this.url = url;
            this.method = method;
            this.body = body;
        }
        
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setMethod(method);
            req.setBody(body);
            Http http = new Http();
            HttpResponse res;
            if (!Test.isRunningTest()) {
	            req.setEndpoint(url);
            	res = http.send(req);
            }
        }

    }
   
}