@isTest
public class PropertyControllerTest {
    
    static testMethod void testFindAll() {
        Boolean success = true;
        try {
            Property__c p = new Property__c(Location__Latitude__s=-71.110448,Location__Longitude__s=42.360642);
            insert p;
	        PropertyPagedResult r = PropertyController.findAll('', 0, 1000000, 8, 1);
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void testFindById() {
        Boolean success = true;
        try {
            Property__c p = new Property__c(Location__Latitude__s=-71.110448,Location__Longitude__s=42.360642);
            insert p;
	        Property__c property = PropertyController.findById(p.Id);
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void getAvailableProperties() {
        Boolean success = true;
        try {
            Property__c p = new Property__c(Location__Latitude__s=-71.110448,Location__Longitude__s=42.360642);
            insert p;
	        Property__c[] r = PropertyController.getAvailableProperties();
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void getSimilarProperties() {
        Boolean success = true;
        try {
            Property__c p = new Property__c(Location__Latitude__s=-71.110448,Location__Longitude__s=42.360642);
            insert p;
	        Property__c[] r = PropertyController.getSimilarProperties(p.Id, 3, 500000, 'Bedrooms');
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

}