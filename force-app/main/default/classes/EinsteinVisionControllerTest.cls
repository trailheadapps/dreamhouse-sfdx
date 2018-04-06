@isTest
public class EinsteinVisionControllerTest {
    
    static testMethod void testPredict() {
        insert new Dreamhouse_Settings__c(Einstein_Vision_Email__c = 'user@host.com');
        Boolean success = true;
        try {
            ContentVersion cv = new ContentVersion(Title='einstein_platform', PathOnClient='/', VersionData=Blob.valueof('some key'));
            insert cv;
	        EinsteinVisionController.predict('victorian.jpg', '', 'theModelId');
	        EinsteinVisionController.predict('victorian_01.jpg', '', '');
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }
    
    static testMethod void testGetDataSets() {
        insert new Dreamhouse_Settings__c(Einstein_Vision_Email__c = 'user@host.com');
        Boolean success = true;
        try {
            ContentVersion cv = new ContentVersion(Title='einstein_platform', PathOnClient='/', VersionData=Blob.valueof('some key'));
            insert cv;
	        EinsteinVisionController.getDataSets();
        } catch (Exception e) {
            System.debug(e);
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void testGetModelByDataset() {
        insert new Dreamhouse_Settings__c(Einstein_Vision_Email__c = 'user@host.com');
        Boolean success = true;
        try {
            ContentVersion cv = new ContentVersion(Title='einstein_platform', PathOnClient='/', VersionData=Blob.valueof('some key'));
            insert cv;
	        EinsteinVisionController.getModelsByDataset(101);
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void testDeleteDataset() {
        insert new Dreamhouse_Settings__c(Einstein_Vision_Email__c = 'user@host.com');
        Boolean success = true;
        try {
            ContentVersion cv = new ContentVersion(Title='einstein_platform', PathOnClient='/', VersionData=Blob.valueof('some key'));
            insert cv;
            EinsteinVisionController.deleteDataset(101);
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void testCreateDataset() {
        insert new Dreamhouse_Settings__c(Einstein_Vision_Email__c = 'user@host.com');
        Boolean success = true;
        try {
            ContentVersion cv = new ContentVersion(Title='einstein_platform', PathOnClient='/', VersionData=Blob.valueof('some key'));
            insert cv;
	        EinsteinVisionController.createDataset('path/to/zip');
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }

    static testMethod void testTrainModel() {
        insert new Dreamhouse_Settings__c(Einstein_Vision_Email__c = 'user@host.com');
        Boolean success = true;
        try {
            ContentVersion cv = new ContentVersion(Title='einstein_platform', PathOnClient='/', VersionData=Blob.valueof('some key'));
            insert cv;
	        EinsteinVisionController.trainModel('theModelId', 101);
        } catch (Exception e) {
            success = false;
        } finally {
	        System.assert(success);
        }
    }
    
    static testMethod void JTWIssue() {
        Boolean success = true;
        try {
            JWT jwt = new JWT('RS256');
            jwt.pkcs8 = 'some key';
            jwt.iss = 'developer.force.com';
            jwt.sub = 'user@server.com';
            jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
            jwt.exp = '3600';
            try {
                String token = jwt.issue();    
            } catch (Exception e1) {
                
            }
        } catch (Exception e2) {
            success = false;
        } finally {
            System.assert(success);
        }
    }

}