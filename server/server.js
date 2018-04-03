let faye = require('faye');
var pg = require('pg');
let express = require('express');
let app = express();
let server = require('http').Server(app);
let notification = require('./modules/notification');

app.use(express.static('www'));
app.use(express.static(path.join('www', 'build')));
app.use(bodyParser.json());

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

// Subscribe to Platform Event
let subscribeToPlatformEvents = () => {
    let client = new faye.Client(org.oauth.instance_url + '/cometd/42.0/');
    client.setHeader('Authorization', 'OAuth ' + org.oauth.access_token);
    client.subscribe('/event/Price_Change_Event__e', function(message) {
        notification.push(message);
    });
};

let bayeux = new faye.NodeAdapter({mount: '/faye', timeout: 45});
bayeux.attach(server);
bayeux.on('disconnect', function(clientId) {
    console.log('Bayeux server disconnect');
});

let PORT = process.env.PORT || 5000;

server.listen(PORT, () => console.log(`Express server listening on ${ PORT }`));