# 📋 Guide des Commandes - T4lkR

> **En mémoire de Jerome Garnier (Psykup25)**

## ⚡ Commandes Essentielles

### 🟢 **Démarrer l'application**
```bash
cd "d:\Web API\T4lkR"
docker-compose up -d
```

### 🛑 **Arrêter l'application**
```bash
cd "d:\Web API\T4lkR"
docker-compose down
```

### 🔄 **Redémarrer l'application**
```bash
cd "d:\Web API\T4lkR"
docker-compose restart
```

### 📊 **Vérifier le statut**
```bash
cd "d:\Web API\T4lkR"
docker-compose ps
```

### 📋 **Voir les logs**
```bash
cd "d:\Web API\T4lkR"
docker-compose logs -f jerome-backend
```

---

## 🔧 Commandes de Maintenance

### **Reconstruire après modifications**
```bash
cd "d:\Web API\T4lkR"
docker-compose build --no-cache
docker-compose up -d
```

### **Nettoyage complet**
```bash
cd "d:\Web API\T4lkR"
docker-compose down -v
docker system prune -a
```

---

## 🌐 URLs de l'Application

- **Frontend** : http://localhost:4201
- **Backend API** : http://localhost:3001
- **Health Check** : http://localhost:3001/api/health
- **Mongo Admin** : http://localhost:8081

---

## 🎮 Messages de Jerome

Au démarrage réussi, vous verrez :
```
🚀 T4lkR Backend démarré sur le port 3001
💝 En mémoire de Jerome Garnier (Psykup25)
🌐 Health check: http://localhost:3001/api/health
🎮 Talkzones: http://localhost:3001/api/talkzones
⚡ Ready to serve Jerome's dream...
```

💝 **En mémoire de Jerome Garnier (Psykup25)**
