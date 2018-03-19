@IsTest
public class PriceChangeAndChatterPostTest {

    @IsTest
    public static void createTestBrokersAndProperties() {
    	System.debug('==== Creating Test Brokers ===');
        List<Broker__c> brokers = new List<Broker__c>();
        brokers.add(new Broker__c(Name='Low Price Broker'));
        brokers.add(new Broker__c(Name='Medium Price Broker'));
        brokers.add(new Broker__c(Name='High Price Broker'));
        insert brokers;
        System.debug('==== '+brokers.size()+' Brokers Created ===');
        System.debug('==== Creating Test Properties ===');
        List<Property__c> properties = new List<Property__c>();
        properties.add(new Property__c(Name='Low Price Property',Broker__c=brokers[0].Id,Monthly_Rent__c=1500,Status__c='Available'));
        properties.add(new Property__c(Name='Medium Price Property',Broker__c=brokers[1].Id,Monthly_Rent__c=3000,Status__c='Available'));
        properties.add(new Property__c(Name='High Price Property',Broker__c=brokers[2].Id,Monthly_Rent__c=5000,Status__c='Available'));
        insert properties;
        System.debug('==== '+properties.size()+' Properties Created ===');

        System.debug('=== Testing Flow / Process Builder ===');
        Test.startTest();
        forcePriceChange(properties);
        Test.stopTest();

        List<FeedItem> posts = findChatterPosts(properties);
        System.assertEquals(3, posts.size());
        for(FeedItem post : posts) {
            if(post.Body == 'The intended price for this currently occupied rental has changed to $1000') {
                System.assertEquals(properties[0].Id,post.ParentId);
            }
            if(post.Body == 'The intended price for this currently occupied rental has changed to $2500') {
                System.assertEquals(properties[1].Id,post.ParentId);
            }
            if(post.Body == 'The intended price for this currently occupied rental has changed to $4500') {
                System.assertEquals(properties[2].Id,post.ParentId);
            }
        }
    }

    public static void forcePriceChange(List<Property__c> properties) {
        for(Property__c property : properties) {
            property.Monthly_Rent__c = property.Monthly_Rent__c - 500;
            System.debug('== NEW PRICE FOR '+property.Name+' IS '+property.Price__c);
        }
        update properties;

    }

    public static List<FeedItem> findChatterPosts(List<Property__c> properties) {
        List<Id> property_ids = new List<Id>();
        for(Property__c property : properties) {
            property_ids.add(property.Id);
        }
    	List<FeedItem> posts = [Select Id, Body, ParentId, Title, Type from FeedItem WHERE ParentId IN :property_ids];
        System.debug('== FOUND '+posts.size()+' FEED ITEMS');
        return posts;
    }



}
