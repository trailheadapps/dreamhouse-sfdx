public with sharing class SampleDataController {
    @AuraEnabled
    public static void importSampleData() {
        // this method will throw an AuraHandledException if the user does not have permission
        // to import sample data
        guardAgainstUsersWithoutCrudPermissions();

        // this method deletes existing property, bot_command, property_favorite and broker
        // records from the database
        deleteExistingData();

        // These three methods load sample data from the the appropriate static resource files
        // and insert them into the database
        loadBotCommands();
        loadBrokers();
        loadProperties();
    }

    private static void deleteExistingData() {
        delete [SELECT Id FROM Bot_Command__c];
        delete [SELECT Id FROM Property_Favorite__c];
        delete [SELECT Id FROM Property__c];
        delete [SELECT Id FROM Broker__c];
    }

    private static String queryStaticResourceToJSON(String resourceName) {
        StaticResource resource = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = :resourceName
            WITH SECURITY_ENFORCED
        ];
        return resource.body.toString();
    }

    private static void loadBotCommands() {
        String botCommandsJSON = queryStaticResourceToJSON('botCommands');

        List<Bot_Command__c> botCommands = (List<Bot_Command__c>) JSON.deserialize(
            botCommandsJSON,
            List<Bot_Command__c>.class
        );
        // CRUD permissions are verified at the top of this method's body in a guard pattern.
        insert botCommands; //NOPMD
    }

    private static void loadBrokers() {
        String brokersJSON = queryStaticResourceToJSON('brokers');
        List<Broker__c> brokers = (List<Broker__c>) JSON.deserialize(
            brokersJSON,
            List<Broker__c>.class
        );
        // CRUD permissions are verified at the top of this method's body in a guard pattern.'
        insert brokers; //NOPMD
    }

    private static void loadProperties() {
        String propertiesJSON = queryStaticResourceToJSON('properties');

        List<Property__c> properties = (List<Property__c>) JSON.deserialize(
            propertiesJSON,
            List<Property__c>.class
        );
        // CRUD permissions are verified at the top of this method's body in a guard pattern.
        insert properties; //NOPMD
    }

    private static void guardAgainstUsersWithoutCrudPermissions() {
        /**
         * Guard method proving CRUD access to the appropriate objects.
         */

        List<String> objectsToCRUDCheck = new List<String>{
            'Bot_Command__c',
            'Property__c',
            'Property_Favorite__c',
            'Broker__c'
        };

        List<Schema.DescribeSObjectResult> objectDescribe = Schema.describeSobjects(
            objectsToCRUDCheck,
            SObjectDescribeOptions.DEFERRED
        );

        for (Schema.DescribeSObjectResult obj : objectDescribe) {
            if (obj.isCreateable() != true && obj.isDeletable() != true) {
                throw new AuraHandledException(
                    'You do not have permission to create or delete ' +
                    obj.getName() +
                    ' objects.'
                );
            }
        }
    }
}
