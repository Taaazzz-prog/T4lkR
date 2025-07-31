# 📱 T4lkR - Présentation du Projet

## 🎯 Vision du Projet

T4lkR est une plateforme de chat social moderne et intuitive, conçue pour créer des communautés thématiques appelées **TalkZones**. L'application permet aux utilisateurs de se connecter, discuter et partager leurs passions dans des environnements dédiés.

## 🏗️ Architecture Technique

### Stack Technologique
- **Frontend** : Angular 20 + TailwindCSS
- **Backend** : Node.js + Express.js
- **Base de données** : MongoDB
- **Communication temps réel** : Socket.IO
- **Authentification** : JWT avec cookies HTTPOnly
- **Containerisation** : Docker + Docker Compose

### Structure du Projet
```
T4lkR/
├── client/                    # Application Angular
│   ├── src/
│   │   ├── app/              # Configuration principale
│   │   ├── public/           # Pages publiques (login, register)
│   │   ├── private/          # Pages authentifiées
│   │   ├── shared/           # Composants et services partagés
│   │   └── assets/           # Images et ressources
│   └── ...
├── server/                   # API Node.js
│   ├── models/              # Modèles MongoDB
│   ├── routes/              # Routes API
│   ├── index.js             # Point d'entrée serveur
│   └── ...
├── docker-compose.yml       # Configuration Docker
└── documentation/           # Documentation du projet
```

## 🎨 Concept des TalkZones

Les **TalkZones** sont le cœur de T4lkR. Chaque zone représente un espace de discussion thématique :

### Catégories Principales
- 🎮 **Gaming** - Discussions sur les jeux vidéo (CS2, etc.)
- ⚽ **Sport** - Échanges sportifs et événements
- 🎬 **Cinéma** - Films, séries et critiques
- 🎵 **Musique** - Découvertes et partages musicaux

### Fonctionnalités des TalkZones
- Chat en temps réel
- Système de membres
- Modération intégrée
- Personnalisation visuelle
- Notifications intelligentes

## 👥 Système Utilisateur

### Profils Utilisateur
- Authentification sécurisée
- Avatars personnalisables
- Statuts de présence (En ligne, Absent, Anonyme)
- Gestion des préférences
- Historique des conversations

### Sécurité
- Chiffrement des mots de passe (bcrypt)
- Tokens JWT sécurisés
- Cookies HTTPOnly
- Validation des données côté serveur
- Protection CORS et Helmet

## 🌟 Expérience Utilisateur

### Design Philosophy
- Interface moderne et épurée
- Navigation intuitive
- Responsive design
- Thème sombre par défaut
- Animations fluides avec TailwindCSS

### Accessibilité
- Compatible mobile et desktop
- Interface adaptative
- Contrôles clavier
- Messages d'erreur clairs
