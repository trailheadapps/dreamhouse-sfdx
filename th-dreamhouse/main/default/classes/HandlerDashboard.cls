public with sharing class HandlerDashboard implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {

        System.debug('**** HandlerDashboard');

        String key = '%' + params[0] + '%';
        List<Dashboard> dashboards = 
            [SELECT Id, Title, FolderName FROM Dashboard
             WHERE Title LIKE :key
             ORDER BY Title
             LIMIT 5];
        
        System.debug(dashboards);

        List<BotRecord> records = new List<BotRecord>();
        
        for (Dashboard d : dashboards) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('Name', d.Title, '/lightning/r/Dashboard/' + d.Id + '/view'));
            fields.add(new BotField('Folder', d.FolderName));
            records.add(new BotRecord(fields));
        }

        System.debug(records);

        return new BotResponse(new BotMessage('Astro', 'Here is a list of dashboards matching "' + params[0] + '":', records));
    }
    
}