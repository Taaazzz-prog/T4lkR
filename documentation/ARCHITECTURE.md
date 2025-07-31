# 🏗️ Architecture Technique - T4lkR

## 📐 Vue d'Ensemble de l'Architecture

T4lkR suit une architecture moderne **Client-Serveur** avec communication temps réel, optimisée pour la scalabilité et la maintenabilité.

```
┌─────────────────┐    HTTP/WS     ┌─────────────────┐    MongoDB    ┌─────────────────┐
│                 │ ◄────────────► │                 │ ◄───────────► │                 │
│  Angular Client │                │  Node.js Server │               │  MongoDB + GridFS│
│                 │                │                 │               │                 │
└─────────────────┘                └─────────────────┘               └─────────────────┘
```

---

## 🎯 Frontend - Angular Architecture

### Structure des Composants
```
src/
├── app/
│   ├── core/                    # Services et intercepteurs globaux
│   │   └── interceptors/
│   ├── app.config.ts           # Configuration principale
│   └── app.routes.ts           # Routing principal
├── public/                     # Pages non authentifiées
│   └── page/
│       ├── accueil/           # Page d'accueil
│       ├── login/             # Connexion
│       └── register/          # Inscription
├── private/                   # Pages authentifiées
│   └── page/
│       ├── home/              # Dashboard principal
│       ├── profile/           # Profil utilisateur
│       ├── gaming/            # Zone gaming
│       ├── sport/             # Zone sport
│       ├── cinema/            # Zone cinéma
│       └── musique/           # Zone musique
└── shared/                    # Composants et services partagés
    ├── services/
    │   ├── api.service.ts     # Communication HTTP
    │   └── user.service.ts    # Gestion utilisateur
    └── components/
        ├── button/            # Composant bouton
        ├── input/             # Composant input
        ├── conversation/      # Interface de chat
        └── talkzone/         # Interface de zone
```

### Services Principaux

#### ApiService
```typescript
@Injectable({ providedIn: 'root' })
export class ApiService {
  private apiUrl = 'http://127.0.0.1:3000/api';
  
  // Authentification
  register(data) → Observable
  login(data) → Observable
  logout() → Observable
  
  // Profil utilisateur
  getProfile() → Observable
  updateProfile(data) → Observable
  changePassword() → Observable
}
```

#### UserService
```typescript
@Injectable({ providedIn: 'root' })
export class UserService {
  private currentUser = signal(null);
  
  // État utilisateur
  setCurrentUser(user) → void
  getCurrentUser() → User | null
  fetchCurrentUser() → Observable
  clearUser() → void
}
```

### Système de Routing

#### Guards d'Authentification
```typescript
canActivate: [() => {
  return fetch('/api/auth/me', { credentials: 'include' })
    .then(res => res.status === 200)
    .catch(() => false);
}]
```

#### Routes Principales
- `/` → Page d'accueil
- `/login` → Connexion
- `/register` → Inscription
- `/home` → Dashboard (protégé)
- `/profile` → Profil (protégé)
- `/talkzone/:zone` → Zone de discussion (protégé)

---

## 🔧 Backend - Node.js Architecture

### Structure du Serveur
```
server/
├── index.js                   # Point d'entrée principal
├── models/                    # Modèles MongoDB
│   ├── User.js               # Modèle utilisateur
│   └── TalkZone.js           # Modèle zone de discussion
├── routes/                    # Routes API
│   ├── auth.js               # Authentification
│   └── users.js              # Gestion utilisateurs
├── middleware/                # Middlewares (à créer)
├── utils/                     # Utilitaires (à créer)
└── config/                    # Configuration (à créer)
```

### Modèles de Données

#### User Model
```javascript
{
  username: String (unique, required),
  email: String (unique, required),
  passwordHash: String (required),
  avatar: String (default: '👤'),
  location: String,
  status: Enum ['En ligne', 'Absent', 'Anonyme'],
  birthDate: Date (required),
  gender: Enum ['Homme', 'Femme', 'Autre'],
  favoriteTalkzones: [ObjectId],
  isActive: Boolean,
  lastSeen: Date,
  timestamps: true
}
```

#### TalkZone Model
```javascript
{
  name: String (required),
  category: Enum ['gaming', 'sport', 'cinema', 'musique'],
  description: String,
  imageUrl: String,
  creator: ObjectId (ref: User),
  members: [ObjectId] (ref: User),
  isActive: Boolean,
  isFeatured: Boolean,
  tags: [String],
  timestamps: true
}
```

### API Routes Implémentées

#### Authentication (`/api/auth`)
```
POST   /register              # Inscription
POST   /login                 # Connexion
POST   /logout                # Déconnexion
GET    /me                    # Utilisateur courant
GET    /user/:id              # Profil utilisateur
PUT    /user/:id              # Mise à jour profil
POST   /user/:id/change-password  # Changement mot de passe
```

### Middleware Stack
```javascript
app.use(helmet());              // Sécurité HTTP
app.use(cors(corsOptions));     // CORS configuré
app.use(express.json());        // Parser JSON
app.use(cookieParser());        // Cookies
app.use(authenticateToken);     // JWT Authentication
```

---

## 🗄️ Base de Données - MongoDB

### Schéma de Base de Données
```
t4lkr (Database)
├── users                      # Collection utilisateurs
├── talkzones                  # Collection zones
├── messages (à créer)         # Collection messages
└── sessions (optionnel)       # Sessions utilisateur
```

### Index et Performance
```javascript
// User indexes
users.createIndex({ "username": 1 }, { unique: true })
users.createIndex({ "email": 1 }, { unique: true })
users.createIndex({ "status": 1 })

// TalkZone indexes
talkzones.createIndex({ "name": "text", "description": "text" })
talkzones.createIndex({ "category": 1 })
talkzones.createIndex({ "isActive": 1 })
```

---

## 🔐 Sécurité et Authentification

### JWT avec Cookies HTTPOnly
```javascript
// Génération token
const token = jwt.sign(
  { id: user._id, username: user.username },
  process.env.JWT_SECRET,
  { expiresIn: '7d' }
);

// Cookie sécurisé
res.cookie('token', token, {
  httpOnly: true,
  secure: false,          // true en production
  sameSite: 'lax',
  maxAge: 7 * 24 * 60 * 60 * 1000
});
```

### Validation des Données
```javascript
// Côté serveur avec Mongoose
username: {
  type: String,
  required: [true, 'Le nom d\'utilisateur est requis'],
  unique: true,
  trim: true,
  minlength: [3, 'Au moins 3 caractères'],
  maxlength: [20, 'Maximum 20 caractères']
}
```

---

## 🌐 Communication Temps Réel

### Socket.IO (À Implémenter)
```javascript
// Configuration serveur
const io = require('socket.io')(server, {
  cors: {
    origin: "http://localhost:4200",
    credentials: true
  }
});

// Événements planifiés
io.on('connection', (socket) => {
  socket.on('join-talkzone', (zone) => {});
  socket.on('leave-talkzone', (zone) => {});
  socket.on('send-message', (data) => {});
  socket.on('typing', (data) => {});
});
```

```typescript
// Configuration client Angular
import { io, Socket } from 'socket.io-client';

export class SocketService {
  private socket: Socket;
  
  connect() {
    this.socket = io('http://localhost:3000', {
      withCredentials: true
    });
  }
  
  joinTalkzone(zone: string) {
    this.socket.emit('join-talkzone', zone);
  }
}
```

---

## 🔄 États et Gestion des Données

### Frontend State Management
```typescript
// Utilisation d'Angular Signals
export class UserService {
  private currentUser = signal<User | null>(null);
  public readonlyUser = computed(() => this.currentUser());
}
```

### Backend Data Flow
```
Client Request → CORS → JWT Auth → Route Handler → Database → Response
```

---

## 🚀 Scalabilité et Performance

### Optimisations Prévues
- **Cache Redis** pour les sessions
- **CDN** pour les assets statiques
- **Load Balancing** pour les instances
- **Database Sharding** pour les messages
- **Message Queues** pour les notifications

### Monitoring
- Health checks sur `/api/health`
- Logs structurés avec Winston (à implémenter)
- Métriques avec Prometheus (à implémenter)

---

## 🧪 Tests et Qualité

### Tests Prévus
```
Backend:
├── Unit tests (Jest)
├── Integration tests (Supertest)
└── Database tests (MongoDB Memory Server)

Frontend:
├── Unit tests (Jasmine/Karma)
├── E2E tests (Cypress)
└── Component tests (Angular Testing Library)
```

### Code Quality
- **ESLint** + **Prettier** pour le formatage
- **Husky** pour les pre-commit hooks
- **SonarQube** pour l'analyse statique (optionnel)
