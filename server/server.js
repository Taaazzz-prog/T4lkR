// 💝 T4lkR Backend - Version simplifiée pour Jerome
// En mémoire de Jerome Garnier (Psykup25)

const http = require('http');
const url = require('url');
const querystring = require('querystring');

// Configuration
const PORT = process.env.PORT || 3001;

// Simuler une base de données simple en mémoire
let users = [
    {
        id: 1,
        username: "jerome",
        email: "jerome@t4lkr.com",
        avatar: "Avatar1.svg",
        isOnline: true
    }
];

let talkzones = [
    {
        id: 1,
        name: "Gaming",
        description: "Zone dédiée aux gamers",
        participants: ["jerome"]
    },
    {
        id: 2,
        name: "Cinéma",
        description: "Parlons de films",
        participants: ["jerome"]
    }
];

// Helper pour les réponses JSON
function sendJSON(res, statusCode, data) {
    res.statusCode = statusCode;
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.end(JSON.stringify(data));
}

// Helper pour lire le body des requêtes POST
function readBody(req, callback) {
    let body = '';
    req.on('data', chunk => {
        body += chunk.toString();
    });
    req.on('end', () => {
        try {
            const data = JSON.parse(body);
            callback(null, data);
        } catch (error) {
            callback(error, null);
        }
    });
}

// Créer le serveur HTTP
const server = http.createServer((req, res) => {
    const parsedUrl = url.parse(req.url, true);
    const path = parsedUrl.pathname;
    const method = req.method;

    console.log(`🔗 ${method} ${path}`);

    // CORS preflight
    if (method === 'OPTIONS') {
        sendJSON(res, 200, { message: 'OK' });
        return;
    }

    // Route de santé
    if (path === '/api/health' && method === 'GET') {
        sendJSON(res, 200, {
            status: 'OK',
            message: 'T4lkR Backend is running - Jerome forever ❤️',
            timestamp: new Date().toISOString()
        });
        return;
    }

    // Routes API
    if (path === '/api/users' && method === 'GET') {
        sendJSON(res, 200, { users });
        return;
    }

    if (path === '/api/talkzones' && method === 'GET') {
        sendJSON(res, 200, { talkzones });
        return;
    }

    if (path === '/api/login' && method === 'POST') {
        readBody(req, (error, data) => {
            if (error) {
                sendJSON(res, 400, { error: 'Invalid JSON' });
                return;
            }

            // Simuler une connexion simple
            const user = users.find(u => u.username === data.username);
            if (user) {
                sendJSON(res, 200, {
                    success: true,
                    user: user,
                    token: 'jerome_token_2024'
                });
            } else {
                sendJSON(res, 401, { error: 'Utilisateur non trouvé' });
            }
        });
        return;
    }

    // Route par défaut
    sendJSON(res, 404, { error: 'Route not found' });
});

// Démarrer le serveur
server.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 T4lkR Backend démarré sur le port ${PORT}`);
    console.log(`💝 En mémoire de Jerome Garnier (Psykup25)`);
    console.log(`🌐 Health check: http://localhost:${PORT}/api/health`);
    console.log(`⚡ Ready to serve Jerome's dream...`);
});

// Gestion des erreurs
server.on('error', (error) => {
    console.error('❌ Erreur serveur:', error);
});

process.on('SIGTERM', () => {
    console.log('👋 Arrêt du serveur T4lkR...');
    server.close(() => {
        console.log('✅ Serveur arrêté proprement');
        process.exit(0);
    });
});
