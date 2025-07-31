# 💝 Script PowerShell de démarrage T4lkR
# En mémoire de Jerome Garnier (Psykup25)
# "Que les conversations commencent !"

# 🎨 Fonction pour afficher du texte coloré
function Write-ColorText {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color
}

# 🖼️ Banner en l'honneur de Jerome
function Show-Banner {
    Write-ColorText "  ████████╗██╗  ██╗██╗     ██╗  ██╗██████╗ " "Magenta"
    Write-ColorText "  ╚══██╔══╝██║  ██║██║     ██║ ██╔╝██╔══██╗" "Magenta"
    Write-ColorText "     ██║   ███████║██║     █████╔╝ ██████╔╝" "Magenta"
    Write-ColorText "     ██║   ╚════██║██║     ██╔═██╗ ██╔══██╗" "Magenta"
    Write-ColorText "     ██║        ██║███████╗██║  ██╗██║  ██║" "Magenta"
    Write-ColorText "     ╚═╝        ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝" "Magenta"
    Write-ColorText "💝 En mémoire de Jerome Garnier (Psykup25)" "White"
    Write-ColorText "   'Les vrais amis ne nous quittent jamais vraiment'" "Cyan"
    Write-Host ""
}

# 🔍 Fonction de vérification des prérequis
function Test-Requirements {
    Write-ColorText "🔍 Vérification des prérequis..." "Blue"
    
    # Vérifier Docker
    try {
        $dockerVersion = docker --version 2>$null
        if ($dockerVersion) {
            Write-ColorText "✅ Docker détecté: $dockerVersion" "Green"
        }
        else {
            throw "Docker non trouvé"
        }
    }
    catch {
        Write-ColorText "❌ Docker n'est pas installé ou accessible" "Red"
        return $false
    }
    
    # Vérifier Docker Compose
    try {
        $composeVersion = docker-compose --version 2>$null
        if ($composeVersion) {
            Write-ColorText "✅ Docker Compose détecté: $composeVersion" "Green"
        }
        else {
            throw "Docker Compose non trouvé"
        }
    }
    catch {
        Write-ColorText "❌ Docker Compose n'est pas installé ou accessible" "Red"
        return $false
    }
    
    Write-ColorText "✅ Tous les prérequis sont satisfaits" "Green"
    return $true
}

# 🧹 Fonction de nettoyage
function Invoke-Cleanup {
    Write-ColorText "🧹 Nettoyage des anciens containers et volumes..." "Yellow"
    
    try {
        docker-compose down -v --remove-orphans 2>$null
        docker system prune -f 2>$null
        Write-ColorText "✅ Nettoyage terminé" "Green"
    }
    catch {
        Write-ColorText "⚠️  Erreur lors du nettoyage (peut être ignorée)" "Yellow"
    }
}

# 🏗️ Fonction de build
function Build-Images {
    Write-ColorText "🏗️ Construction des images Docker..." "Blue"
    
    Write-ColorText "   Building Jerome's Backend..." "Cyan"
    docker-compose build jerome-backend
    
    if ($LASTEXITCODE -ne 0) {
        Write-ColorText "❌ Erreur lors de la construction du backend" "Red"
        return $false
    }
    
    Write-ColorText "   Building Jerome's Frontend..." "Cyan"
    docker-compose build jerome-frontend
    
    if ($LASTEXITCODE -ne 0) {
        Write-ColorText "❌ Erreur lors de la construction du frontend" "Red"
        return $false
    }
    
    Write-ColorText "✅ Images construites avec succès" "Green"
    return $true
}

# 🚀 Fonction de démarrage
function Start-Services {
    Write-ColorText "🚀 Démarrage des services T4lkR..." "Blue"
    
    # Démarrer la base de données en premier
    Write-ColorText "   Démarrage de MongoDB (Jerome's Database)..." "Cyan"
    docker-compose up -d jerome-mongodb
    
    # Attendre que MongoDB soit prêt
    Write-ColorText "   Attente de MongoDB..." "Yellow"
    Start-Sleep -Seconds 10
    
    # Démarrer Redis
    Write-ColorText "   Démarrage de Redis Cache..." "Cyan"
    docker-compose up -d jerome-redis
    
    # Démarrer le backend
    Write-ColorText "   Démarrage du Backend API..." "Cyan"
    docker-compose up -d jerome-backend
    
    # Attendre que le backend soit prêt
    Write-ColorText "   Attente du Backend..." "Yellow"
    Start-Sleep -Seconds 15
    
    # Démarrer le frontend
    Write-ColorText "   Démarrage du Frontend Angular..." "Cyan"
    docker-compose up -d jerome-frontend
    
    # Démarrer l'interface d'admin MongoDB
    Write-ColorText "   Démarrage de l'interface d'administration..." "Cyan"
    docker-compose up -d jerome-mongo-express
    
    Write-ColorText "✅ Tous les services sont démarrés !" "Green"
}

# 📊 Fonction d'affichage du statut
function Show-Status {
    Write-ColorText "📊 Statut des services T4lkR" "Blue"
    docker-compose ps
    Write-Host ""
    
    Write-ColorText "🌐 Accès aux services :" "Magenta"
    Write-ColorText "   • Frontend (Jerome's Interface):  http://localhost:4200" "White"
    Write-ColorText "   • Backend API:                   http://localhost:3000" "White"
    Write-ColorText "   • API Health Check:              http://localhost:3000/api/health" "White"
    Write-ColorText "   • MongoDB Admin:                 http://localhost:8081" "White"
    Write-ColorText "     └─ User: jerome / Pass: psykup25admin" "White"
    Write-Host ""
    
    Write-ColorText "💡 Commandes utiles :" "Yellow"
    Write-ColorText "   • Voir les logs:         docker-compose logs -f" "White"
    Write-ColorText "   • Arrêter les services:  docker-compose down" "White"
    Write-ColorText "   • Redémarrer:           docker-compose restart" "White"
}

# 🔍 Fonction de vérification de santé
function Test-Health {
    Write-ColorText "🏥 Vérification de la santé des services..." "Blue"
    
    # Vérifier le Backend
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:3000/api/health" -TimeoutSec 5 -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            Write-ColorText "✅ Backend API fonctionne" "Green"
        }
        else {
            Write-ColorText "❌ Backend API ne répond pas correctement" "Red"
        }
    }
    catch {
        Write-ColorText "❌ Backend API ne répond pas" "Red"
    }
    
    # Vérifier le Frontend
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:4200" -TimeoutSec 5 -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            Write-ColorText "✅ Frontend fonctionne" "Green"
        }
        else {
            Write-ColorText "❌ Frontend ne répond pas correctement" "Red"
        }
    }
    catch {
        Write-ColorText "❌ Frontend ne répond pas" "Red"
    }
}

# 📋 Menu principal
function Show-MainMenu {
    Write-ColorText "📋 Que souhaitez-vous faire ?" "Blue"
    Write-Host "1) 🚀 Démarrage complet (recommandé)"
    Write-Host "2) 🏗️ Build uniquement"
    Write-Host "3) ▶️  Démarrer les services"
    Write-Host "4) 📊 Voir le statut"
    Write-Host "5) 🏥 Vérification de santé"
    Write-Host "6) 🧹 Nettoyer et redémarrer"
    Write-Host "7) 🛑 Arrêter tous les services"
    Write-Host "8) 📝 Voir les logs"
    Write-Host "9) 🌐 Ouvrir les interfaces web"
    Write-Host "0) ❌ Quitter"
    Write-Host ""
    
    $choice = Read-Host "Votre choix"
    
    switch ($choice) {
        "1" {
            if (Test-Requirements) {
                Invoke-Cleanup
                if (Build-Images) {
                    Start-Services
                    Show-Status
                    Test-Health
                }
            }
        }
        "2" {
            if (Test-Requirements) {
                Build-Images
            }
        }
        "3" {
            Start-Services
            Show-Status
        }
        "4" {
            Show-Status
        }
        "5" {
            Test-Health
        }
        "6" {
            if (Test-Requirements) {
                Invoke-Cleanup
                if (Build-Images) {
                    Start-Services
                    Show-Status
                }
            }
        }
        "7" {
            Write-ColorText "🛑 Arrêt des services..." "Yellow"
            docker-compose down
            Write-ColorText "✅ Services arrêtés" "Green"
        }
        "8" {
            Write-ColorText "📝 Logs des services (Ctrl+C pour quitter):" "Blue"
            docker-compose logs -f
        }
        "9" {
            Write-ColorText "🌐 Ouverture des interfaces web..." "Blue"
            Start-Process "http://localhost:4200"
            Start-Process "http://localhost:3000/api/health"
            Start-Process "http://localhost:8081"
        }
        "0" {
            Write-ColorText "👋 Au revoir ! Jerome serait fier du travail accompli." "Magenta"
            exit
        }
        default {
            Write-ColorText "❌ Choix invalide" "Red"
            Show-MainMenu
        }
    }
}

# 🎯 Point d'entrée principal
Clear-Host
Show-Banner
Write-ColorText "🎯 Gestionnaire T4lkR - Version Jerome" "White"
Write-ColorText "   Développé avec ❤️ en mémoire de Jerome Garnier (Psykup25)" "Cyan"
Write-Host ""

# Vérifier si des arguments sont passés
if ($args.Count -eq 0) {
    Show-MainMenu
}
else {
    switch ($args[0]) {
        "start" {
            if (Test-Requirements) {
                Invoke-Cleanup
                if (Build-Images) {
                    Start-Services
                    Show-Status
                }
            }
        }
        "stop" {
            docker-compose down
        }
        "status" {
            Show-Status
        }
        "health" {
            Test-Health
        }
        "logs" {
            docker-compose logs -f
        }
        default {
            Write-ColorText "Usage: .\start-jerome.ps1 [start|stop|status|health|logs]" "Red"
            exit 1
        }
    }
}
