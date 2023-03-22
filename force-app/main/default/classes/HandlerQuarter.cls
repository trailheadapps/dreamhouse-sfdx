public with sharing class HandlerQuarter implements BotHandler {
    public BotResponse handle(
        String utterance,
        String[] params,
        Map<String, String> session,
        String fileName,
        String fileContent
    ) {
        return new BotResponse(
            new BotMessage(
                'Bot',
                'Your quarter so far:',
                'https://s3-us-west-2.amazonaws.com/dev-or-devrl-s3-bucket/sample-apps/charts/quarter2.png'
            )
        );
    }
}
