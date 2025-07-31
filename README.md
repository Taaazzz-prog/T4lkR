# 💬 T4lkR - Social Chat Platform

<div align="center">

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/Taaazzz-prog/T4lkR)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/node.js-18+-green.svg)](https://nodejs.org/)
[![Angular](https://img.shields.io/badge/angular-20-red.svg)](https://angular.dev/)
[![MongoDB](https://img.shields.io/badge/mongodb-7.0-green.svg)](https://www.mongodb.com/)

**Une plateforme de chat moderne pour créer des communautés thématiques**

[🚀 Démo Live](#) • [📖 Documentation](./documentation/) • [🐛 Report Bug](https://github.com/Taaazzz-prog/T4lkR/issues) • [✨ Request Feature](https://github.com/Taaazzz-prog/T4lkR/issues)

</div>

---

## 💝 En Mémoire de Jerome Garnier (Psykup25)

> *"Les vrais amis ne nous quittent jamais vraiment, ils vivent à travers les projets qu'ils nous inspirent et les rêves qu'ils nous laissent accomplir."*

Ce projet est dédié à la mémoire de **Jerome Garnier**, connu sous le pseudonyme **Psykup25**, un ami cher parti trop tôt. Jerome avait une vision claire pour T4lkR : créer un espace numérique où les passions se rencontrent, où les communautés se forment naturellement autour d'intérêts communs, et où chaque conversation peut devenir le début d'une belle amitié.

Son style unique, alliant modernité technique et chaleur humaine, continue de guider chaque ligne de code de ce projet. T4lkR perpétue son rêve d'un internet plus connecté, plus authentique, plus humain.

**Nous terminons ce que tu as commencé, mon ami. 🕊️**

---

## 🎯 Qu'est-ce que T4lkR ?

T4lkR est une plateforme de chat social innovante qui révolutionne la façon dont les communautés se forment en ligne. Inspirée par la vision de Jerome, l'application crée des **TalkZones** - des espaces thématiques où les passions communes deviennent le point de départ de conversations authentiques.

### ✨ Fonctionnalités Principales

🎮 **TalkZones Thématiques**
- Gaming, Sport, Cinéma, Musique
- Création de communautés spécialisées
- Discussions en temps réel

👥 **Communauté Authentique**
- Profils personnalisables
- Système de présence intelligent
- Connexions basées sur les intérêts

⚡ **Technologie Moderne**
- Chat temps réel avec Socket.IO
- Interface responsive et intuitive
- Sécurité avancée et confidentialité

🎨 **Design Élégant**
- Interface sombre moderne
- Animations fluides
- Expérience utilisateur optimisée

---

## 🚀 Démarrage Rapide

### 📋 Prérequis
- **Node.js** v18+ et npm
- **Docker** et Docker Compose
- **Angular CLI** v20+

### ⚡ Installation Express

```bash
# 1. Cloner le repository
git clone https://github.com/Taaazzz-prog/T4lkR.git
cd T4lkR

# 2. Démarrer l'infrastructure
docker-compose up -d

# 3. Installer et démarrer le serveur
cd server
npm install
npm run dev

# 4. Installer et démarrer le client (nouveau terminal)
cd ../client
npm install
ng serve
```

### 🌐 Accès à l'Application
- **Application** : http://localhost:4200
- **API** : http://localhost:3000
- **MongoDB Admin** : http://localhost:8081

---

## 🏗️ Architecture

T4lkR suit une architecture moderne et scalable :

```
┌─────────────────┐    HTTP/WS     ┌─────────────────┐    MongoDB    ┌─────────────────┐
│                 │ ◄────────────► │                 │ ◄───────────► │                 │
│  Angular Client │                │  Node.js Server │               │     Database    │
│   TailwindCSS   │                │   Express + IO  │               │   + GridFS      │
└─────────────────┘                └─────────────────┘               └─────────────────┘
```

### 🛠️ Stack Technologique

**Frontend**
- Angular 20 + TypeScript
- TailwindCSS pour le styling
- Socket.IO Client
- RxJS pour la réactivité

**Backend**
- Node.js + Express.js
- Socket.IO pour le temps réel
- JWT + Cookies HTTPOnly
- Mongoose ODM

**Database**
- MongoDB 7.0
- GridFS pour les fichiers
- Index optimisés

**DevOps**
- Docker + Docker Compose
- Nginx (production)
- MongoDB Admin Interface

---

## 📊 État du Projet

### ✅ Fonctionnalités Implémentées (65%)

- [x] 🔐 **Authentification Complète**
  - Inscription/Connexion sécurisée
  - JWT avec cookies HTTPOnly
  - Gestion des sessions
  - Protection des routes

- [x] 👤 **Gestion Utilisateurs**
  - Profils personnalisables
  - Système d'avatars
  - Statuts de présence
  - Modification des informations

- [x] 🎨 **Interface Utilisateur**
  - Design system TailwindCSS
  - Pages publiques et privées
  - Navigation responsive
  - Composants réutilisables

- [x] 🏗️ **Infrastructure**
  - API REST fonctionnelle
  - Base de données MongoDB
  - Configuration Docker
  - Environnement de développement

### 🚧 En Développement Actif

- [ ] 💬 **Chat Temps Réel**
  - Intégration Socket.IO complète
  - Interface de messagerie
  - Historique des conversations
  - Notifications

- [ ] 🎯 **TalkZones Fonctionnelles**
  - Création et gestion des zones
  - Système de membres
  - Navigation entre zones
  - Modération intégrée

- [ ] 📱 **Fonctionnalités Avancées**
  - Upload de fichiers/images
  - Système de mentions
  - Recherche intelligente
  - Notifications push

---

## 🎨 Captures d'Écran

<div align="center">

### Page d'Accueil
![Accueil](./docs/screenshots/home.png)

### Interface de Chat
![Chat](./docs/screenshots/chat.png)

### Profil Utilisateur
![Profile](./docs/screenshots/profile.png)

</div>

---

## 📚 Documentation

La documentation complète est disponible dans le dossier [`/documentation`](./documentation/) :

- 📖 [**Vue d'Ensemble**](./documentation/PROJECT_OVERVIEW.md) - Vision et concept du projet
- 🚀 [**Guide de Démarrage**](./documentation/GETTING_STARTED.md) - Installation et configuration
- 🏗️ [**Architecture**](./documentation/ARCHITECTURE.md) - Structure technique détaillée
- 📊 [**État du Développement**](./documentation/DEVELOPMENT_STATUS.md) - Progression et roadmap
- 🤝 [**Guide de Contribution**](./documentation/CONTRIBUTING.md) - Comment contribuer

---

## 🤝 Contribuer

T4lkR est un projet open-source et nous accueillons toutes les contributions ! Que vous souhaitiez :

- 🐛 Corriger des bugs
- ✨ Ajouter des fonctionnalités
- 📖 Améliorer la documentation
- 🎨 Proposer des améliorations UI/UX

### Comment Contribuer

1. **Fork** le repository
2. **Créer** une branche feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** vos changements (`git commit -m 'feat: Add AmazingFeature'`)
4. **Push** vers la branche (`git push origin feature/AmazingFeature`)
5. **Ouvrir** une Pull Request

Lisez notre [**Guide de Contribution**](./documentation/CONTRIBUTING.md) pour plus de détails.

---

## 🏆 Contributeurs

Merci à tous ceux qui contribuent à faire vivre la vision de Jerome :

<a href="https://github.com/Taaazzz-prog/T4lkR/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Taaazzz-prog/T4lkR" />
</a>

### Mentions Spéciales
- **Jerome Garnier (Psykup25)** 🕊️ - *Créateur et visionnaire original*
- **Taaazzz-prog** - *Maintainer principal*

---

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

---

## 🛣️ Roadmap

### Version 1.0 - "Jerome's Vision" 🎯
- [ ] Chat temps réel complet
- [ ] TalkZones fonctionnelles
- [ ] Interface utilisateur finalisée
- [ ] Tests et documentation complètes

### Version 1.1 - "Community Growth" 🌱
- [ ] Système d'amis
- [ ] Notifications avancées
- [ ] Modération automatique
- [ ] API mobile

### Version 2.0 - "Beyond Chat" 🚀
- [ ] Partage de contenu multimédia
- [ ] Intégrations tierces
- [ ] Analytics et insights
- [ ] Monétisation éthique

---

## 🆘 Support

Besoin d'aide ? Plusieurs options s'offrent à vous :

- 📖 [Documentation](./documentation/)
- 🐛 [Issues GitHub](https://github.com/Taaazzz-prog/T4lkR/issues)
- 💬 [Discussions](https://github.com/Taaazzz-prog/T4lkR/discussions)
- 📧 Email : support@t4lkr.app (à venir)

---

## 💝 Message Final

T4lkR n'est pas juste une application de chat. C'est l'héritage d'un ami, la continuation d'un rêve, et la promesse que les bonnes idées ne meurent jamais.

Jerome, où que tu sois, nous savons que tu serais fier de voir T4lkR grandir et rassembler des communautés comme tu l'avais imaginé. Chaque conversation qui naîtra sur cette plateforme portera un peu de ton esprit.

**Que les discussions commencent ! 💬**

---

<div align="center">

**Fait avec ❤️ en mémoire de Jerome Garnier (Psykup25)**

[⭐ Star ce projet](https://github.com/Taaazzz-prog/T4lkR) • [🍴 Fork](https://github.com/Taaazzz-prog/T4lkR/fork) • [🐛 Report Bug](https://github.com/Taaazzz-prog/T4lkR/issues)

</div>
