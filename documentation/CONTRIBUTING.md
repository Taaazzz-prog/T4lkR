# 🎯 Guide de Contribution - T4lkR

## 🤝 Comment Contribuer

Ce guide vous explique comment contribuer efficacement au projet T4lkR en respectant les standards et la vision du projet.

---

## 📋 Avant de Commencer

### Prérequis
- Lire la documentation complète dans `/documentation/`
- Configurer l'environnement de développement local
- Comprendre l'architecture du projet
- Respecter le style de code existant

### Setup Initial
```bash
# Fork et clone du repository
git clone https://github.com/YOUR_USERNAME/T4lkR.git
cd T4lkR

# Ajouter le repository principal
git remote add upstream https://github.com/Taaazzz-prog/T4lkR.git

# Installer les dépendances
cd server && npm install
cd ../client && npm install
```

---

## 🌟 Types de Contributions

### 🐛 Corrections de Bugs
1. Créer une issue décrivant le bug
2. Créer une branche `bugfix/description-courte`
3. Corriger le problème avec tests
4. Créer une Pull Request

### ✨ Nouvelles Fonctionnalités
1. Discuter de la fonctionnalité dans une issue
2. Créer une branche `feature/nom-fonctionnalite`
3. Développer en suivant les standards
4. Ajouter tests et documentation
5. Créer une Pull Request

### 📚 Documentation
1. Créer une branche `docs/sujet`
2. Améliorer ou ajouter de la documentation
3. Créer une Pull Request

### 🎨 Améliorations UI/UX
1. Créer une branche `ui/description`
2. Respecter le design system existant
3. Tester sur différents appareils
4. Créer une Pull Request

---

## 🔄 Workflow Git

### Structure des Branches
```
main                    # Version stable
├── develop            # Développement principal
├── feature/socket-io  # Nouvelle fonctionnalité
├── bugfix/login-issue # Correction de bug
└── hotfix/security    # Correction urgente
```

### Naming Convention
- `feature/nom-fonctionnalite` : Nouvelles fonctionnalités
- `bugfix/description-bug` : Corrections de bugs
- `hotfix/correction-urgente` : Corrections critiques
- `docs/sujet-documentation` : Documentation
- `ui/amelioration-interface` : Améliorations UI

### Commits Standards
```bash
# Format : type(scope): description
feat(auth): add socket.io authentication
fix(chat): resolve message duplication issue
docs(readme): update installation instructions
style(ui): improve talkzone card design
refactor(api): optimize user query performance
test(unit): add user service tests
```

### Types de Commits
- `feat` : Nouvelle fonctionnalité
- `fix` : Correction de bug
- `docs` : Documentation
- `style` : Formatage, UI/UX
- `refactor` : Refactoring code
- `perf` : Amélioration performance
- `test` : Tests
- `chore` : Maintenance

---

## 🎯 Standards de Développement

### Backend (Node.js)

#### Structure des Fichiers
```javascript
// routes/example.js
const express = require('express');
const router = express.Router();
const { authenticateToken } = require('../middleware/auth');

/**
 * GET /api/example
 * Description de la route
 */
router.get('/', authenticateToken, async (req, res) => {
  try {
    // Logique métier
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
```

#### Standards API
```javascript
// Réponses JSON standardisées
{
  "success": true,
  "data": {},
  "message": "Action réussie"
}

// Erreurs standardisées
{
  "success": false,
  "error": "Message d'erreur",
  "code": "ERROR_CODE"
}
```

#### Validation des Données
```javascript
// Utiliser Mongoose validation
const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: [true, 'Le nom d\'utilisateur est requis'],
    validate: {
      validator: (value) => value.length >= 3,
      message: 'Minimum 3 caractères'
    }
  }
});
```

### Frontend (Angular)

#### Structure des Composants
```typescript
@Component({
  selector: 'app-example',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './example.html',
  styleUrls: ['./example.css']
})
export class ExampleComponent implements OnInit {
  // Propriétés publiques d'abord
  public data = signal<any[]>([]);
  
  // Propriétés privées
  private destroyed$ = new Subject<void>();
  
  constructor(
    private exampleService: ExampleService
  ) {}
  
  ngOnInit() {
    this.loadData();
  }
  
  ngOnDestroy() {
    this.destroyed$.next();
    this.destroyed$.complete();
  }
  
  private loadData() {
    // Implémentation
  }
}
```

#### Services Angular
```typescript
@Injectable({ providedIn: 'root' })
export class ExampleService {
  private apiUrl = 'http://127.0.0.1:3000/api';
  
  constructor(private http: HttpClient) {}
  
  getData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/example`, {
      withCredentials: true
    });
  }
}
```

#### Styling avec TailwindCSS
```html
<!-- Utiliser les classes utilitaires -->
<div class="bg-dark-800 text-white p-4 rounded-lg shadow-lg">
  <h2 class="text-xl font-bold mb-2">Titre</h2>
  <p class="text-gray-300">Contenu</p>
</div>
```

---

## 🧪 Tests et Qualité

### Tests Backend
```javascript
// tests/auth.test.js
describe('Authentication Routes', () => {
  beforeEach(async () => {
    await User.deleteMany({});
  });
  
  test('POST /register should create user', async () => {
    const userData = {
      username: 'testuser',
      email: 'test@example.com',
      password: 'password123'
    };
    
    const response = await request(app)
      .post('/api/auth/register')
      .send(userData)
      .expect(201);
      
    expect(response.body.success).toBe(true);
  });
});
```

### Tests Frontend
```typescript
// example.component.spec.ts
describe('ExampleComponent', () => {
  let component: ExampleComponent;
  let fixture: ComponentFixture<ExampleComponent>;
  
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ExampleComponent, HttpClientTestingModule]
    }).compileComponents();
    
    fixture = TestBed.createComponent(ExampleComponent);
    component = fixture.componentInstance;
  });
  
  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
```

### Commandes de Test
```bash
# Backend
cd server
npm test              # Tests unitaires
npm run test:watch   # Mode watch
npm run test:coverage # Coverage

# Frontend
cd client
ng test              # Tests unitaires
ng e2e              # Tests e2e
```

---

## 📝 Documentation

### Code Documentation
```javascript
/**
 * Authentifie un utilisateur avec Socket.IO
 * @param {Object} socket - Socket client
 * @param {string} token - Token JWT
 * @returns {Promise<User>} Utilisateur authentifié
 * @throws {Error} Si le token est invalide
 */
async function authenticateSocket(socket, token) {
  // Implémentation
}
```

```typescript
/**
 * Service de gestion des TalkZones
 * Gère les opérations CRUD et la communication temps réel
 */
@Injectable({ providedIn: 'root' })
export class TalkzoneService {
  /**
   * Rejoint une TalkZone
   * @param zoneId ID de la zone à rejoindre
   * @returns Observable avec le résultat
   */
  joinZone(zoneId: string): Observable<any> {
    // Implémentation
  }
}
```

### README des Modules
Chaque nouveau module important doit avoir son README :
```markdown
# Module Example

## Description
Description du module et de son rôle.

## Usage
```typescript
// Exemple d'utilisation
```

## API
Liste des méthodes et propriétés publiques.
```

---

## 🔍 Process de Review

### Checklist Pull Request
- [ ] Code fonctionnel et testé localement
- [ ] Tests unitaires ajoutés/mis à jour
- [ ] Documentation mise à jour
- [ ] Respect des standards de code
- [ ] Pas de données sensibles dans le code
- [ ] Performance acceptable
- [ ] Compatible avec les navigateurs cibles

### Template Pull Request
```markdown
## Description
Description claire des changements.

## Type de changement
- [ ] Bug fix
- [ ] Nouvelle fonctionnalité
- [ ] Breaking change
- [ ] Documentation

## Tests
- [ ] Tests unitaires passent
- [ ] Tests manuels effectués
- [ ] Couverture de test maintenue

## Captures d'écran
Si applicable, ajouter des captures d'écran.
```

---

## 🚨 Règles Importantes

### À Faire
- ✅ Tester localement avant commit
- ✅ Écrire des messages de commit clairs
- ✅ Respecter l'architecture existante
- ✅ Documenter les nouvelles fonctionnalités
- ✅ Gérer les erreurs correctement
- ✅ Utiliser TypeScript côté client

### À Éviter
- ❌ Commit direct sur main/develop
- ❌ Gros commits avec multiples changements
- ❌ Code non testé
- ❌ Données sensibles en dur
- ❌ Console.log en production
- ❌ Modification des configs sans discussion

---

## 🆘 Aide et Support

### Ressources
- **Documentation** : `/documentation/`
- **Issues** : GitHub Issues
- **Discussions** : GitHub Discussions
- **Email** : [Maintainer email]

### Questions Fréquentes
1. **Comment démarrer le projet ?** → Voir `GETTING_STARTED.md`
2. **Erreur de connexion DB ?** → Vérifier Docker Compose
3. **CORS errors ?** → Vérifier les URLs dans la config
4. **Tests qui échouent ?** → Nettoyer node_modules et réinstaller

### Maintainers
- **Taaazzz-prog** - Maintainer principal
- **[Autres contributeurs]** - Reviewers

---

## 🎖️ Reconnaissance

Les contributeurs sont listés dans :
- GitHub Contributors
- `CONTRIBUTORS.md` (à créer)
- Mentions dans les releases

Merci de respecter ces guidelines pour maintenir la qualité et la cohérence du projet T4lkR ! 🚀
