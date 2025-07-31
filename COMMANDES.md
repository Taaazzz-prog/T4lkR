# 🚀 T4lkR - Commandes Rapides

> Guide de référence rapide pour gérer l'application T4lkR

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
docker-compose logs -f
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

### **Redémarrer un service spécifique**
```bash
cd "d:\Web API\T4lkR"
docker-compose restart jerome-backend
docker-compose restart jerome-frontend
```

---

## 🌐 URLs de Test

- **Frontend** : http://localhost:4201
- **Backend API** : http://localhost:3001
- **Health Check** : http://localhost:3001/api/health
- **Mongo Admin** : http://localhost:8081

---

## 🆘 Dépannage Rapide

### **Port occupé**
```bash
# Voir quel processus utilise le port
netstat -ano | findstr :3001

# Tuer le processus
Stop-Process -Id [PID] -Force
```

### **Problème de démarrage**
```bash
cd "d:\Web API\T4lkR"
docker-compose down
docker-compose build --no-cache
docker-compose up -d
docker-compose logs jerome-backend
```

### **Test de connectivité**
```bash
curl http://localhost:3001/api/health
curl http://localhost:3001/api/talkzones
```

---

## 💡 Messages de Jerome

Au démarrage réussi, vous devriez voir :
```
🚀 T4lkR Backend démarré sur le port 3001
💝 En mémoire de Jerome Garnier (Psykup25)
🌐 Health check: http://localhost:3001/api/health
🎮 Talkzones: http://localhost:3001/api/talkzones
⚡ Ready to serve Jerome's dream...
```

---

💝 **En mémoire de Jerome Garnier (Psykup25)**
