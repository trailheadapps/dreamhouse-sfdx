public with sharing class HandlerHelpTopic implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
		if (session == null) {
			List<BotMessageButton> buttons = new List<BotMessageButton>();
            buttons.add(new BotMessageButton('User', 'User'));
            buttons.add(new BotMessageButton('Admin', 'Admin'));
            buttons.add(new BotMessageButton('Developer', 'Developer'));
            BotMessage message = new BotMessage('Bot', 'What best describes your role?', buttons);
            session = new Map<String, String>();
            session.put('nextCommand', 'HandlerHelpTopic');
            return new BotResponse(message, session);
        }
		List<BotItem> items = new List<BotItem>();
        if (utterance == 'User') {
            items.add(new BotItem('Salesforce User Tour', 'https://trailhead.salesforce.com/modules/lex_salesforce_tour'));
            items.add(new BotItem('Lightning Experience Features', 'https://trailhead.salesforce.com/modules/lex_migration_whatsnew'));
            items.add(new BotItem('Lightning Experience Chatter Basics', 'https://trailhead.salesforce.com/modules/lex_implementation_chatter'));
        } else if (utterance == 'Admin') {
            items.add(new BotItem('Lightning Experience Basics', 'https://trailhead.salesforce.com/modules/lex_migration_introduction'));
            items.add(new BotItem('Lightning Experience Features', 'https://trailhead.salesforce.com/modules/lex_migration_whatsnew'));
            items.add(new BotItem('Lightning Apps', 'https://trailhead.salesforce.com/modules/lightning_apps'));
            items.add(new BotItem('Lightning Experience Reports & Dashboards', 'https://trailhead.salesforce.com/modules/lex_implementation_reports_dashboards'));
        } else if (utterance == 'Developer') {
            items.add(new BotItem('Lightning Experience Development', 'https://trailhead.salesforce.com/modules/lex_dev_overview'));
            items.add(new BotItem('Lightning Components Basics', 'https://trailhead.salesforce.com/modules/lex_dev_lc_basics'));
            items.add(new BotItem('Visualforce & Lightning Experience', 'https://trailhead.salesforce.com/modules/lex_dev_visualforce'));
        }
        BotMessage message = new BotMessage('Bot', 'I recommend the following Trailhead Modules:', items);
        return new BotResponse(message);
    }
    
}