// Copyright Epic Games, Inc. All Rights Reserved.
var enableRedirectionLinks = false;
var enableRESTAPI = true;

// some flows are needed only in dev mode (CORS, for instance)
const DEVELOPMENT_ENV = true;

const defaultConfig = {
	// The port clients connect to the matchmaking service over HTTP
	HttpPort: 80,
	UseHTTPS: false,
	// The matchmaking port the signaling service connects to the matchmaker
	MatchmakerPort: 9999,

	// Log to file
	LogToFile: true,
	
	EnableWebserver: true,
};

// Similar to the Signaling Server (SS) code, load in a config.json file for the MM parameters
const argv = require('yargs').argv;

var configFile = (typeof argv.configFile != 'undefined') ? argv.configFile.toString() : 'config.json';
console.log(`configFile ${configFile}`);
const config = require('./modules/config.js').init(configFile, defaultConfig);
console.log("Config: " + JSON.stringify(config, null, '\t'));

const express = require('express');
var cors = require('cors');
const app = express();
const http = require('http').Server(app);
const fs = require('fs');
const crypto = require('crypto');
const path = require('path');
const logging = require('./modules/logging.js');
logging.RegisterConsoleLogger();

if (config.LogToFile) {
	logging.RegisterFileLogger('./logs');
}

// A list of all the Cirrus server which are connected to the Matchmaker.
var cirrusServers = new Map();
var urlMap = new Map();
//
// Parse command line.
//

if (typeof argv.HttpPort != 'undefined') {
	config.HttpPort = argv.HttpPort;
}
if (typeof argv.MatchmakerPort != 'undefined') {
	config.MatchmakerPort = argv.MatchmakerPort;
}

http.listen(config.HttpPort, () => {
    console.log('HTTP listening on *:' + config.HttpPort);
});


if (config.UseHTTPS) {
	//HTTPS certificate details
	const options = {
		key: fs.readFileSync(path.join(__dirname, './certificates/client-key.pem')),
		cert: fs.readFileSync(path.join(__dirname, './certificates/client-cert.pem'))
	};

	var https = require('https').Server(options, app);

	//Setup http -> https redirect
	console.log('Redirecting http->https');
	app.use(function (req, res, next) {
		if (!req.secure) {
			if (req.get('Host')) {
				var hostAddressParts = req.get('Host').split(':');
				var hostAddress = hostAddressParts[0];
				if (httpsPort != 443) {
					hostAddress = `${hostAddress}:${httpsPort}`;
				}
				return res.redirect(['https://', hostAddress, req.originalUrl].join(''));
			} else {
				console.error(`unable to get host name from header. Requestor ${req.ip}, url path: '${req.originalUrl}', available headers ${JSON.stringify(req.headers)}`);
				return res.status(400).send('Bad Request');
			}
		}
		next();
	});

	https.listen(443, function () {
		console.log('Https listening on 443');
	});
}

let htmlDirectory = 'html/sample'
if(config.EnableWebserver) {
	// Setup folders

	if (fs.existsSync('html/custom')) {
		app.use(express.static(path.join(__dirname, '/html/custom')))
		htmlDirectory = 'html/custom'
	} else {
		app.use(express.static(path.join(__dirname, '/html/sample')))
	}
}

if (DEVELOPMENT_ENV) {
	const corsOptions = {
		origin: 'https://localhost',
	}
	app.all('*', function (req, res, next) {
		res.header('Access-Control-Allow-Origin', '*');
		res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
		res.header('Access-Control-Allow-Headers', 'Content-Type');
		next();
	});
	app.get('/serverAvailable', cors(corsOptions), retrieveSignallingServerAvailable);

} else {
	app.get('/serverAvailable', retrieveSignallingServerAvailable);
}

function retrieveSignallingServerAvailable(req, res) {
	let signallingServerAddress = null;
	let serverID = req.params.serverID;
	let cirrusServer;
	
	console.log('retrieve Signalling Server Available. serverID requested? ', serverID, urlMap.has(serverID));
	if (serverID != undefined && urlMap.has(serverID)) {
		cirrusServer = cirrusServers.get(serverID);
		signallingServerAddress = `${cirrusServer.address}:${cirrusServer.port}`;
		if (res) {
			res.json({ url: signallingServerAddress });
		}
		console.log(`Redirect to ${cirrusServer.address}:${cirrusServer.port}`);
	} else {
		cirrusServer = getAvailableCirrusServer();
		console.log('retrieve Signalling Server Available getting available ', cirrusServer);
		if (cirrusServer != undefined) {
			signallingServerAddress = `${cirrusServer.address}:${cirrusServer.port}`;
			console.log(`Redirect to ${cirrusServer.address}:${cirrusServer.port}`);
			if (res) {
				res.json({ url: 'ws://' + signallingServerAddress });
			}
		} else {
			sendBusyResponse(res);
		}

	}
}

function sendBusyResponse(res) {
	console.log('send Busy Response');
	res.json({ msgType: 'serverFull' });
}

// No servers are available so send some simple JavaScript to the client to make
// it retry after a short period of time.
function sendRetryResponse(res) {
	// find check if a custom template should be used or the sample one
	let html = fs.readFileSync(`${htmlDirectory}/index.html`, { encoding: 'utf8' })
	html = html.replace(/\$\{cirrusServers\.size\}/gm, cirrusServers.size)

	res.setHeader('content-type', 'text/html')
	res.send(html)
}

// Get a Cirrus server if there is one available which has no clients connected.
function getAvailableCirrusServer(playerType) {
	for (cirrusServer of cirrusServers.values()) {
		if ((cirrusServer.numConnectedClients === 0 
			&& cirrusServer.ready === true 
			&& playerType == null) || (cirrusServer.numConnectedClients === 0 
				&& cirrusServer.ready === true 
				&& playerType !== null && (
				(playerType === 'User' && cirrusServer.currentUsers < cirrusServer.maxUsers) 
				|| (playerType === 'Vendor' && cirrusServer.currentVendors < cirrusServer.maxVendors)
			))
		) {

			// Check if we had at least 10 seconds since the last redirect, avoiding the 
			// chance of redirecting 2+ users to the same SS before they click Play.
			// In other words, give the user 10 seconds to click play button the claim the server.
			if( cirrusServer.hasOwnProperty('lastRedirect')) {
				if( ((Date.now() - cirrusServer.lastRedirect) / 1000) < 10 )
					continue;
			}
			cirrusServer.lastRedirect = Date.now();

			return cirrusServer;
		}
	}
	
	console.log('WARNING: No empty Cirrus servers are available');
	return undefined;
}

if(enableRESTAPI) {
	// Handle REST signalling server only request.
	app.options('/signallingserver', cors())
	app.get('/signallingserver', cors(),  (req, res) => {
		cirrusServer = getAvailableCirrusServer();
		if (cirrusServer != undefined) {
			res.json({ signallingServer: `${cirrusServer.address}:${cirrusServer.port}`});
			console.log(`Returning ${cirrusServer.address}:${cirrusServer.port}`);
		} else {
			res.json({ signallingServer: '', error: 'No signalling servers available'});
		}
	});
}

if(enableRedirectionLinks) {
	// Handle standard URL.
	app.get('/', (req, res) => {
		cirrusServer = getAvailableCirrusServer();
		if (cirrusServer != undefined) {
			res.redirect(`http://${cirrusServer.address}:${cirrusServer.port}/`);
			//console.log(req);
			console.log(`Redirect to ${cirrusServer.address}:${cirrusServer.port}`);
		} else {
			sendRetryResponse(res);
		}
	});

	// Handle URL with custom HTML.
	app.get('/custom_html/:htmlFilename', (req, res) => {
		cirrusServer = getAvailableCirrusServer();
		if (cirrusServer != undefined) {
			res.redirect(`http://${cirrusServer.address}:${cirrusServer.port}/custom_html/${req.params.htmlFilename}`);
			console.log(`Redirect to ${cirrusServer.address}:${cirrusServer.port}`);
		} else {
			sendRetryResponse(res);
		}
	});
}

//
// Connection to Cirrus.
//

const net = require('net');

function disconnect(connection) {
	console.log(`Ending connection to remote address ${connection.remoteAddress}`);
	connection.end();
}

function getCirrusKeyFromConnection(connectionData) {
	return connectionData.remoteAddress;
}

const matchmaker = net.createServer((connection) => {
	connection.on('data', (data) => {
		try {
			message = JSON.parse(data);

			if(message)
				console.log(`Message TYPE: ${message.type}`);
		} catch(e) {
			console.log(`ERROR (${e.toString()}): Failed to parse Cirrus information from data: ${data.toString()}`);
			disconnect(connection);
			return;
		}
		if (message.type === 'connect') {
			// A Cirrus server connects to this Matchmaker server.

			do {
				id = crypto.randomBytes(3).toString('hex');
			} while (urlMap.has(id));


			cirrusServer = {
				address: message.address,
				port: message.port,
				numConnectedClients: 0,
				lastPingReceived: Date.now(),
				maxUsers: config.maxUsers,
				maxVendors: config.maxVendors,
				currentUsers: 0,
				currentVendors: 0,
			};
			cirrusServer.ready = message.ready === true;

			cirrusKey = getCirrusKeyFromConnection(connection);
			cirrusServers.set(cirrusKey, cirrusServer);

			urlMap.set(connection, cirrusServer);

			// Handles disconnects between MM and SS to not add dupes with numConnectedClients = 0 and redirect users to same SS
			// Check if player is connected and doing a reconnect. message.playerConnected is a new variable sent from the SS to
			// help track whether or not a player is already connected when a 'connect' message is sent (i.e., reconnect).
			if(message.playerConnected == true) {
				cirrusServer.numConnectedClients = 1;
			}

			// Find if we already have a ciruss server address connected to (possibly a reconnect happening)
			let server = [...cirrusServers.entries()].find(([key, val]) => val.address === cirrusServer.address && val.port === cirrusServer.port);

			// if a duplicate server with the same address isn't found -- add it to the map as an available server to send users to.
			if (!server || server.size <= 0) {
				console.log(`Adding connection for ${cirrusServer.address.split(".")[0]} with playerConnected: ${message.playerConnected}`)
				cirrusServers.set(connection, cirrusServer);
            } else {
				console.log(`RECONNECT: cirrus server address ${cirrusServer.address.split(".")[0]} already found--replacing. playerConnected: ${message.playerConnected}`)
				var foundServer = cirrusServers.get(server[0]);
				
				// Make sure to retain the numConnectedClients from the last one before the reconnect to MM
				if (foundServer) {					
					cirrusServers.set(connection, cirrusServer);
					console.log(`Replacing server with original with numConn: ${cirrusServer.numConnectedClients}`);
					cirrusServers.delete(server[0]);
				} else {
					cirrusServers.set(connection, cirrusServer);
					console.log("Connection not found in Map() -- adding a new one");
				}
			}
		} else if (message.type === 'streamerConnected') {
			// The stream connects to a Cirrus server and so is ready to be used
			cirrusServer = cirrusServers.get(connection);
			if(cirrusServer) {
				cirrusServer.ready = true;
				console.log(`Cirrus server ${cirrusServer.address}:${cirrusServer.port} ready for use`);
			} else {
				disconnect(connection);
			}
		} else if (message.type === 'streamerDisconnected') {
			// The stream connects to a Cirrus server and so is ready to be used
			cirrusServer = cirrusServers.get(connection);
			if(cirrusServer) {
				cirrusServer.ready = false;
				console.log(`Cirrus server ${cirrusServer.address}:${cirrusServer.port} no longer ready for use`);
			} else {
				disconnect(connection);
			}
		} else if (message.type === 'clientConnected') {
			// A client connects to a Cirrus server.
			cirrusServer = cirrusServers.get(connection);
			if(cirrusServer) {
				if (message.playerType === 'User') {
					if (cirrusServer.currentUsers < cirrusServer.maxUsers) {
						cirrusServer.currentUsers++;
					} else {
						console.log(`Max Users reached for this Cirrus Server. Disconneting ${cirrusServer.address}:${cirrusServer.port}. Player type: ${message.playerType}`);
						disconnect(connection);
					}
				}
				if (message.playerType === 'Vendor' && cirrusServer.currentVendors < cirrusServer.maxVendors) {
					if (cirrusServer.currentVendors < cirrusServer.maxVendors) {
						cirrusServer.currentVendors++;
					} else {
						console.log(`Max Vendors reached for this Cirrus Server. Disconneting ${cirrusServer.address}:${cirrusServer.port}. Player type: ${message.playerType}`);
						disconnect(connection);
					}
				}
				cirrusServer.numConnectedClients++;
				console.log(`Client connected to Cirrus server ${cirrusServer.address}:${cirrusServer.port}. Player type: ${message.playerType}`);
			} else {
				disconnect(connection);
			}
		} else if (message.type === 'clientDisconnected') {
			// A client disconnects from a Cirrus server.
			cirrusServer = cirrusServers.get(connection);
			if(cirrusServer) {
				cirrusServer.numConnectedClients--;
				console.log(`Client disconnected from Cirrus server ${cirrusServer.address}:${cirrusServer.port}`);
				if(cirrusServer.numConnectedClients === 0) {
					// this make this server immediately available for a new client
					cirrusServer.lastRedirect = 0;
				}
			} else {				
				disconnect(connection);
			}
		} else if (message.type === 'ping') {
			cirrusServer = cirrusServers.get(connection);
			if(cirrusServer) {
				cirrusServer.lastPingReceived = Date.now();
			} else {				
				disconnect(connection);
			}
		} else {
			console.log('ERROR: Unknown data: ' + JSON.stringify(message));
			cirrusKey = getCirrusKeyFromConnection(connection);
			urlMap.delete(cirrusServer.get(cirrusKey).id);
			disconnect(connection);
		}
	});

	// A Cirrus server disconnects from this Matchmaker server.
	connection.on('error', () => {
		cirrusServer = cirrusServers.get(connection);
		if(cirrusServer) {
			cirrusServers.delete(connection);
			console.log(`Cirrus server ${cirrusServer.address}:${cirrusServer.port} disconnected from Matchmaker`);
		} else {
			console.log(`Disconnected machine that wasn't a registered cirrus server, remote address: ${connection.remoteAddress}`);
		}
	});
});

matchmaker.listen(config.MatchmakerPort, () => {
	console.log('Matchmaker listening on *:' + config.MatchmakerPort);
});
