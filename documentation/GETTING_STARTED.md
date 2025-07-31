# 🚀 Guide de Démarrage - T4lkR

## 📋 Prérequis

### Outils Nécessaires
- **Node.js** v18+ et npm
- **Angular CLI** v20+
- **Docker** et Docker Compose
- **Git** pour le versioning

### Installation des Outils
```bash
# Vérifier les versions
node --version
npm --version
docker --version
docker-compose --version

# Installer Angular CLI
npm install -g @angular/cli@20
```

---

## 🛠️ Installation du Projet

### 1. Cloner le Repository
```bash
git clone https://github.com/Taaazzz-prog/T4lkR.git
cd T4lkR
```

### 2. Configuration de l'Infrastructure
```bash
# Démarrer MongoDB avec Docker
docker-compose up -d mongodb mongo-express

# Vérifier que les services tournent
docker-compose ps
```

### 3. Configuration du Serveur
```bash
cd server

# Installer les dépendances
npm install

# Créer le fichier .env (optionnel, des valeurs par défaut existent)
touch .env
```

**Contenu du fichier .env (optionnel) :**
```env
NODE_ENV=development
MONGODB_URI=mongodb://localhost:27017/t4lkr
JWT_SECRET=your-super-secret-jwt-key-for-t4lkr-2024
JWT_EXPIRES_IN=7d
BCRYPT_ROUNDS=12
PORT=3000
CLIENT_URL=http://localhost:4200
```

### 4. Configuration du Client
```bash
cd ../client

# Installer les dépendances
npm install
```

---

## ▶️ Lancement de l'Application

### Méthode 1 : Développement Complet
```bash
# Terminal 1 : Infrastructure
docker-compose up -d

# Terminal 2 : Serveur API
cd server
npm run dev

# Terminal 3 : Client Angular
cd client
ng serve
```

### Méthode 2 : Avec Docker (Backend uniquement)
```bash
# Démarrer tous les services
docker-compose up -d

# Client en local
cd client
ng serve
```

---

## 🌐 URLs d'Accès

| Service             | URL                              | Description                      |
| ------------------- | -------------------------------- | -------------------------------- |
| **Application Web** | http://localhost:4200            | Interface utilisateur principale |
| **API Backend**     | http://localhost:3000            | API REST                         |
| **API Health**      | http://localhost:3000/api/health | Status de l'API                  |
| **MongoDB Admin**   | http://localhost:8081            | Interface d'administration DB    |

### Credentials MongoDB Admin
- **Username** : `admin`
- **Password** : `admin123`

---

## 🧪 Tests et Vérifications

### Vérifier l'API
```bash
# Health check
curl http://localhost:3000/api/health

# Test de base
curl http://localhost:3000/api/test
```

### Vérifier la Base de Données
1. Accéder à http://localhost:8081
2. Se connecter avec les credentials
3. Vérifier la base `t4lkr`

### Vérifier l'Application
1. Accéder à http://localhost:4200
2. Créer un compte utilisateur
3. Se connecter
4. Naviguer dans l'interface

---

## 🛠️ Commandes de Développement

### Serveur (Node.js)
```bash
cd server

# Développement avec auto-reload
npm run dev

# Production
npm start

# Logs détaillés
DEBUG=* npm run dev
```

### Client (Angular)
```bash
cd client

# Serveur de développement
ng serve

# Build de production
ng build

# Tests
ng test

# Linting
ng lint
```

### Docker
```bash
# Démarrer tous les services
docker-compose up -d

# Voir les logs
docker-compose logs -f

# Arrêter les services
docker-compose down

# Rebuild des images
docker-compose up --build
```

---

## 🔧 Résolution de Problèmes

### Problèmes Courants

#### Port déjà utilisé
```bash
# Vérifier les ports occupés
netstat -an | grep :3000
netstat -an | grep :4200

# Tuer les processus
lsof -ti:3000 | xargs kill -9
lsof -ti:4200 | xargs kill -9
```

#### Problèmes MongoDB
```bash
# Vérifier le statut de MongoDB
docker-compose logs mongodb

# Redémarrer MongoDB
docker-compose restart mongodb

# Nettoyer les données
docker-compose down -v
docker-compose up -d
```

#### Problèmes de Dépendances
```bash
# Nettoyer et réinstaller
rm -rf node_modules package-lock.json
npm install

# Clear cache npm
npm cache clean --force
```

#### Problèmes CORS
- Vérifier que le client accède bien à `http://127.0.0.1:3000`
- S'assurer que `withCredentials: true` est défini dans les requêtes

---

## 📝 Logs et Debugging

### Logs Serveur
```bash
# Voir les logs en temps réel
docker-compose logs -f backend

# Logs détaillés avec debug
cd server
DEBUG=express:* npm run dev
```

### Logs Client
- Ouvrir les DevTools du navigateur
- Onglet Console pour les logs JavaScript
- Onglet Network pour les requêtes HTTP

---

## 🚧 Développement

### Structure des Branches
- `main` : Version stable
- `develop` : Développement actuel
- `feature/*` : Nouvelles fonctionnalités
- `hotfix/*` : Corrections urgentes

### Workflow Recommandé
1. Créer une branche feature
2. Développer et tester localement
3. Commit avec messages clairs
4. Push et créer une Pull Request
5. Review et merge

### Standards de Code
- **Backend** : ESLint + Prettier
- **Frontend** : Angular style guide
- **Commits** : Format conventionnel (`feat:`, `fix:`, `docs:`)
