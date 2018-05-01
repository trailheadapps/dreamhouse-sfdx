public class YelpServiceController {
    @AuraEnabled
    public static String getListByLatLon (String latlon, String searchTerm) {
            String url = 'https://grewis-yelp.herokuapp.com/search?address=' + latlon + '&term=' + EncodingUtil.urlEncode(searchTerm, 'UTF-8');
            String resultList = getHttp(url);
            return resultList;   
    }
    
    private static String getHttp (String url) {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');    
        req.setEndpoint(url);
        HTTPResponse res = http.send(req);
        return res.getBody();
    }
    
    @AuraEnabled
    public static String getListByAddress(String address, String searchTerm) {
    try {
            String url = 'https://grewis-yelp.herokuapp.com/search?address=' + EncodingUtil.urlEncode(address, 'UTF-8') + '&term=' + EncodingUtil.urlEncode(searchTerm, 'UTF-8');
            String resultList = getHttp(url);
            return resultList;
        }  catch(Exception ex){
            return '{"error": "' + ex.getMessage() + '"}';
        }
    }
    
}