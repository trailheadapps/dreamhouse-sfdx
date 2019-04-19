trigger RejectDuplicatePropertyFavorite on Property_Favorite__c (before insert) {
    
    // NOTE: this trigger needs to be bulkified
    
    Property_Favorite__c favorite = Trigger.New[0];
    List<Property_Favorite__c> dupes = [Select Id FROM Property_Favorite__C WHERE Property__c = :favorite.Property__c AND User__c = :favorite.User__c];
    if (!dupes.isEmpty()) {
        favorite.addError('duplicate');
    }

}