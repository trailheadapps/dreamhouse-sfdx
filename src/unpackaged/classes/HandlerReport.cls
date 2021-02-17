public with sharing class HandlerReport implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {

        String key = '%' + params[0] + '%';
        List<Report> reports = 
            [SELECT Id, Name, FolderName FROM Report
             WHERE Name LIKE :key
             ORDER BY Name
             LIMIT 5];
        
        List<BotRecord> records = new List<BotRecord>();
        
        for (Report r : reports) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('Name', r.Name, '/lightning/r/Report/' + r.Id + '/view'));
            fields.add(new BotField('Folder', r.FolderName));
            records.add(new BotRecord(fields));
        }

        return new BotResponse(new BotMessage('Astro', 'Here is a list of reports matching "' + params[0] + '":', records));

    }
    
}