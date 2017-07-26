public class PostPriceChangeToSlack {

    @InvocableMethod(label='Post Price Change Notification to Slack')
    public static void postToSlack(List<Id> propertyId) {
		String slackURL;
	    Dreamhouse_Settings__c settings = Dreamhouse_Settings__c.getOrgDefaults();
        if (!Test.isRunningTest()) {
        	if (settings == null || settings.Slack_Property_Webhook_URL__c == null) {
		        System.Debug('Slack_Property_Webhook_URL not set. Aborting PostPriceChangeToSlack process action');
                return;
            } else {
            	slackURL = settings.Slack_Property_Webhook_URL__c;   
            }
        }
        Id propId = propertyId[0]; // If bulk, only post first to avoid spamming
        Property__c property = [SELECT Address__c, City__c, State__c, Price__c from Property__c WHERE Id=:propId];
        String message = 'Price change: ' + property.Address__c + ', ' + property.City__c + ' ' + property.State__c + ' is now *$' + property.Price__c.setScale(0).format() + '*';
        System.Debug(message);
        
		Map<String,Object> payload = new Map<String,Object>();
		payload.put('text', message);
		payload.put('mrkdwn', true);
        String body = JSON.serialize(payload);    
        System.Debug(body);
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