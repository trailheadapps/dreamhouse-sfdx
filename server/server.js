let faye = require('faye'),
    pg = require('pg'),
    express = require('express'),
    app = express(),
    server = require('http').Server(app),
    notification = require('./modules/notification'),
    salesforce = require('./modules/salesforce');

app.use(express.static('www'));

let client = new pg.Client(process.env.DATABASE_URL);
client.connect();

app.get('/property', (req, res) => {
    client.query('SELECT * FROM Property__c', (error, data) => {
        res.json(data.rows);
    });
});

app.get('/property/:id', (req, res) => {
    client.query('SELECT * FROM Property__c WHERE ID=$1', [req.params.sfid], (error, data) => {
        res.json(data.rows);
    });
});

let bayeux = new faye.NodeAdapter({ mount: '/faye', timeout: 45 });
bayeux.attach(server);
bayeux.on('disconnect', function (clientId) {
    console.log('Bayeux server disconnect');
});

saleforce.authenticate().then((oauth) => {
    let client = new faye.Client(oauth.instance_url + '/cometd/42.0/');
    client.setHeader('Authorization', 'OAuth ' + oauth.access_token);
    client.subscribe('/event/Price_Change_Event__e', function (message) {
        notification.push(message);
    });
});

server.listen(PORT, () => console.log(`Express server listening on ${process.env.PORT}`));