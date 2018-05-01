@isTest
public class TestInTheNeighborhoodController {
    static testMethod void test() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        String searchTerm = 'restaurant';
        String latlon = '37.7935226, -122.3966302';
        YelpServiceController.getListByLatLon(latlon, searchTerm);
        
        String address = '136 Brecon Court, Redwood City, Ca, 94062';                
        YelpServiceController.getListByAddress(address, searchTerm);
    }
    static testMethod void testother() {
        Account a = new Account(Name = 'test');
        insert a;
        YelpDemoController.objectSelect('Account', a.Id);
        Contact c = new Contact(LastName = 'test');
        insert c;
        YelpDemoController.objectSelect('Contact', c.Id);
    }
}