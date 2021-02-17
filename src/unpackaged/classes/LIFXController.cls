public with sharing class LIFXController {

    private static final Dreamhouse_Settings__c settings = Dreamhouse_Settings__c.getOrgDefaults();

    @AuraEnabled
    public static String getLights() {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');    
        req.setHeader('Authorization', 'Bearer ' + settings.LIFX_TOKEN__C);
        req.setEndpoint(settings.LIFX_URL__C + '/all');
		try {
            HTTPResponse res = http.send(req);
			return res.getBody();        	
        } catch(Exception ex){
            return '{"error": "' + ex.getMessage() + '"}';
        }
    }
    
    @AuraEnabled
    public static String setPower(String lightId, Boolean isOn) {
        return LIFXController.setState(lightId, '{"power": "' + (isOn == true ? 'on' : 'off') + '"}');
    }
    
    @AuraEnabled
    public static String setBrightness(String lightId, Decimal brightness) {
        return LIFXController.setState(lightId, '{"brightness": ' + (brightness / 100) + '}');
    }

    public static String setState(String lightId, String state) {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('PUT');    
        req.setEndpoint(settings.LIFX_URL__C + '/' + lightId + '/state');
        req.setHeader('Authorization', 'Bearer ' + settings.LIFX_TOKEN__C);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(state);
		try {
            HTTPResponse res = http.send(req);
			return res.getBody();        	
        } catch(Exception ex){
            return '{"error": "' + ex.getMessage() + '"}';
        }
    }
        
}