// 💝 T4lkR Backend - Version hybride pour Jerome
// En mémoire de Jerome Garnier (Psykup25)
// Combinaison des fonctionnalités de base avec Express

const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware de base
app.use(cors({
    origin: ['http://localhost:4201', 'http://127.0.0.1:4201'],
    credentials: true
}));

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Simuler une base de données simple en mémoire (comme notre version qui marche)
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
        description: "Zone dédiée aux gamers - Créée par Jerome",
        participants: ["jerome"]
    },
    {
        id: 2,
        name: "Cinéma",
        description: "Parlons de films - Passion de Jerome",
        participants: ["jerome"]
    },
    {
        id: 3,
        name: "Sport",
        description: "Zone sportive - Jerome aimait le sport",
        participants: ["jerome"]
    },
    {
        id: 4,
        name: "Musique",
        description: "Partageons notre musique - Jerome adorait la musique",
        participants: ["jerome"]
    }
];

// Routes principales
app.get('/', (req, res) => {
    res.json({
        message: 'T4lkR API Server 🚀',
        version: '2.0.0 - En mémoire de Jerome',
        environment: process.env.NODE_ENV || 'development',
        tribute: '💝 Jerome Garnier (Psykup25) - Toujours dans nos cœurs'
    });
});

app.get('/api/health', (req, res) => {
    console.log('🔗 GET /api/health');
    res.json({
        status: 'OK',
        message: 'T4lkR Backend is running - Jerome forever ❤️',
        timestamp: new Date().toISOString(),
        environment: process.env.NODE_ENV || 'development',
        database: 'In-Memory (fonctionnel)',
        tribute: 'Dédié à Jerome Garnier (Psykup25)'
    });
});

// Routes des talkzones
app.get('/api/talkzones', (req, res) => {
    console.log('🔗 GET /api/talkzones');
    res.json({
        talkzones: talkzones,
        total: talkzones.length,
        message: 'Zones créées avec amour par Jerome'
    });
});

app.get('/api/talkzones/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const talkzone = talkzones.find(t => t.id === id);

    if (!talkzone) {
        return res.status(404).json({ error: 'Talkzone non trouvée' });
    }

    console.log(`🔗 GET /api/talkzones/${id}`);
    res.json({
        talkzone: talkzone,
        message: `Zone "${talkzone.name}" - Un héritage de Jerome`
    });
});

// Routes des utilisateurs
app.get('/api/users', (req, res) => {
    console.log('🔗 GET /api/users');
    res.json({
        users: users,
        total: users.length,
        message: 'Utilisateurs de la communauté Jerome'
    });
});

app.get('/api/users/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const user = users.find(u => u.id === id);

    if (!user) {
        return res.status(404).json({ error: 'Utilisateur non trouvé' });
    }

    console.log(`🔗 GET /api/users/${id}`);
    res.json({
        user: user,
        message: `Profil de ${user.username}`
    });
});

// Route d'authentification basique
app.post('/api/auth/login', (req, res) => {
    const { username, password } = req.body;

    console.log(`🔗 POST /api/auth/login - User: ${username}`);

    // Authentification simple pour la démo
    if (username === 'jerome' && password === 'test') {
        res.json({
            success: true,
            message: 'Connexion réussie - Bienvenue Jerome!',
            user: users[0],
            token: 'demo-token-jerome-2025'
        });
    } else {
        res.status(401).json({
            success: false,
            message: 'Identifiants incorrects'
        });
    }
});

// Route pour créer une nouvelle talkzone
app.post('/api/talkzones', (req, res) => {
    const { name, description } = req.body;

    if (!name || !description) {
        return res.status(400).json({ error: 'Nom et description requis' });
    }

    const newTalkzone = {
        id: talkzones.length + 1,
        name: name,
        description: description,
        participants: ["jerome"], // Jerome est toujours le premier participant
        createdAt: new Date().toISOString(),
        createdBy: "jerome"
    };

    talkzones.push(newTalkzone);

    console.log(`🔗 POST /api/talkzones - Created: ${name}`);
    res.status(201).json({
        success: true,
        message: `Talkzone "${name}" créée avec succès`,
        talkzone: newTalkzone,
        tribute: 'Nouvelle zone dans l\'esprit de Jerome'
    });
});

// Gestion des erreurs
app.use((err, req, res, next) => {
    console.error('❌ Erreur serveur:', err);
    res.status(500).json({
        error: 'Erreur interne du serveur',
        message: 'Jerome aurait trouvé une solution...',
        timestamp: new Date().toISOString()
    });
});

// Route 404
app.use('*', (req, res) => {
    res.status(404).json({
        error: 'Route not found',
        message: 'Cette route n\'existe pas dans l\'univers de Jerome',
        path: req.originalUrl
    });
});

// Démarrage du serveur
app.listen(PORT, '0.0.0.0', () => {
    console.log('🚀 T4lkR Backend démarré sur le port', PORT);
    console.log('💝 En mémoire de Jerome Garnier (Psykup25)');
    console.log('🌐 Health check: http://localhost:' + PORT + '/api/health');
    console.log('🎮 Talkzones: http://localhost:' + PORT + '/api/talkzones');
    console.log('⚡ Ready to serve Jerome\'s dream...');
});

module.exports = app;
