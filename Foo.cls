public class Foo {
    void foo() {
        
        String myString = 'MY_HARDCODED_STRING';
        String myString2 = 'MY_HARDCODED_STRING';
        String myString3 = 'MY_HARDCODED_STRING';
        
        Blob hardCodedIV = Blob.valueOf('Hardcoded IV 123');
        Blob myKey = Blob.valueOf(myString);
        Blob data = Blob.valueOf('Data to be encrypted');
        Blob encrypted = Crypto.encrypt('AES128', myKey, hardCodedIV, data);
        
        
        List<Order__c> orders = [SELECT Purchased__c,Product_Category_1__c,Product_Category_Units_1__c,Product_Category_2__c,Product_Category_Units_2__c FROM Order__c];
    }
}
