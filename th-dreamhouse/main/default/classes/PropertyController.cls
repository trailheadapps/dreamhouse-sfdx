global with sharing class PropertyController {

    @AuraEnabled(cacheable=true)
    public static Property__c[] getPropertyList(String searchKey, Decimal minPrice, Decimal maxPrice, Integer numberBedrooms, Integer numberBathrooms, String visualSearchKey) {
        String key = '%' + searchKey + '%';
        String visualKey = '%' + visualSearchKey + '%';
        return [SELECT Id, address__c, city__c, state__c, description__c, price__c, baths__c, beds__c, thumbnail__c, location__latitude__s, location__longitude__s FROM property__c
                      WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
                      AND (title__c LIKE :visualKey OR city__c LIKE :visualKey OR tags__c LIKE :visualKey)
                      AND price__c >= :minPrice
					  AND price__c <= :maxPrice
                      AND beds__c >= :numberBedrooms
                      AND baths__c >= :numberBathrooms
                      ORDER BY price__c LIMIT 100];
    }

    @AuraEnabled(cacheable=true)
    public static PropertyListPage getPropertyListPage(String searchKey, Decimal minPrice, Decimal maxPrice, Integer numberBedrooms, Integer numberBathrooms, String visualSearchKey, Decimal pageSize, Decimal pageNumber) {
		Integer pSize = (Integer)pageSize;
        String key = '%' + searchKey + '%';
        String visualKey = '%' + visualSearchKey + '%';
        Integer offset = ((Integer)pageNumber - 1) * pSize;
        PropertyListPage page =  new PropertyListPage();
        page.pageSize = pSize;
        page.pageNumber = (Integer) pageNumber;
        page.total = [SELECT count() FROM property__c 
                      WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
                      AND (title__c LIKE :visualKey OR city__c LIKE :visualKey OR tags__c LIKE :visualKey)
                      AND price__c >= :minPrice
                  	  AND price__c <= :maxPrice
                      AND beds__c >= :numberBedrooms
                      AND baths__c >= :numberBathrooms];
          page.properties = [SELECT Id, address__c, city__c, state__c, description__c, price__c, baths__c, beds__c, thumbnail__c FROM property__c 
                      WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
                      AND (title__c LIKE :visualKey OR city__c LIKE :visualKey OR tags__c LIKE :visualKey)
                      AND price__c >= :minPrice
					  AND price__c <= :maxPrice
                      AND beds__c >= :numberBedrooms
                      AND baths__c >= :numberBathrooms
                      ORDER BY price__c LIMIT :pSize OFFSET :offset];
        return page;
    }

    @AuraEnabled(cacheable=true)
    public static Property__c findById(Id propertyId) {
        return [SELECT id, name, beds__c, baths__c, address__c, city__c, state__c, assessed_value__c, price__c, Date_Listed__c, Location__Latitude__s, Location__Longitude__s 
                FROM Property__c
                WHERE Id=:propertyId];
    }

    @AuraEnabled
    public static Property__c[] getAvailableProperties() {
        return [SELECT id, name, address__c, city__c, price__c, Date_Listed__c, Days_On_Market__c, Date_Agreement__c, Location__Latitude__s, Location__Longitude__s 
                FROM Property__c
                WHERE Date_Listed__c != NULL AND (Date_Agreement__c = NULL OR Date_Agreement__c = LAST_N_DAYS:90)];
    }
    
    @AuraEnabled
    public static Property__c[] getAtRiskProperties() {
        return [SELECT id, name, address__c, city__c, price__c, Thumbnail__c, Predicted_Days_On_Market__c 
                FROM Property__c
                WHERE Predicted_Days_On_Market__c > 30];
    }

    @AuraEnabled(cacheable=true)
    public static List<Property__c> getComparableProperties(Id propertyId) {
        Property__c property = [SELECT Id, Price__c FROM Property__c WHERE Id = :propertyId];
        return [
            SELECT Id, Name, Address__c, City__c, State__c, Zip__c, Beds__c, Baths__c, Price__c, Predicted_Days_On_Market__c 
                FROM Property__c WHERE Id != :propertyId AND Price__c > :property.Price__c - 100000 AND Price__c < :property.Price__c + 100000 LIMIT 8
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Property__c> getSimilarProperties (Id propertyId, Decimal bedrooms, Decimal price, String searchCriteria) {
        if (searchCriteria == 'Bedrooms') {
            return [
                SELECT Id, Name, Address__c, City__c, State__c, Zip__c, Beds__c, Baths__c, Price__c, Broker__c, Status__c, Thumbnail__c 
                FROM Property__c WHERE Id != :propertyId AND Beds__c = :bedrooms
            ];
        } else {
            return [
                SELECT Id, Name, Address__c, City__c, State__c, Zip__c, Beds__c, Baths__c, Price__c, Broker__c, Status__c, Thumbnail__c 
                FROM Property__c WHERE Id != :propertyId AND Price__c > :price - 100000 AND Price__c < :price + 100000
            ];
        }
    }

    @AuraEnabled
    public static List<ContentVersion> getPictures (Id propertyId) {

        List<ContentDocumentLink> links = [select id, LinkedEntityId, ContentDocumentId from ContentDocumentLink where LinkedEntityId=:propertyId];

        if (links.isEmpty()) {
            return null;
        }

        Set<Id> contentIds = new Set<Id>();

        for (ContentDocumentLink link :links) {
            contentIds.add(link.ContentDocumentId);
        }

        return [SELECT Id, Title FROM ContentVersion WHERE ContentDocumentId IN :contentIds AND IsLatest=true];
    }

}