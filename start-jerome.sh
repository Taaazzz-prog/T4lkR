#!/bin/bash

# 💝 Script de démarrage T4lkR
# En mémoire de Jerome Garnier (Psykup25)
# "Que les conversations commencent !"

# 🎨 Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# 🖼️ Banner en l'honneur de Jerome
echo -e "${PURPLE}"
echo "  ████████╗██╗  ██╗██╗     ██╗  ██╗██████╗ "
echo "  ╚══██╔══╝██║  ██║██║     ██║ ██╔╝██╔══██╗"
echo "     ██║   ███████║██║     █████╔╝ ██████╔╝"
echo "     ██║   ╚════██║██║     ██╔═██╗ ██╔══██╗"
echo "     ██║        ██║███████╗██║  ██╗██║  ██║"
echo "     ╚═╝        ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${WHITE}💝 En mémoire de Jerome Garnier (Psykup25)${NC}"
echo -e "${CYAN}   'Les vrais amis ne nous quittent jamais vraiment'${NC}"
echo ""

# 🔍 Fonction de vérification des prérequis
check_requirements() {
    echo -e "${BLUE}🔍 Vérification des prérequis...${NC}"
    
    # Vérifier Docker
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Docker n'est pas installé${NC}"
        exit 1
    fi
    
    # Vérifier Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${RED}❌ Docker Compose n'est pas installé${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Tous les prérequis sont satisfaits${NC}"
}

# 🧹 Fonction de nettoyage
cleanup() {
    echo -e "${YELLOW}🧹 Nettoyage des anciens containers et volumes...${NC}"
    docker-compose down -v --remove-orphans 2>/dev/null || true
    docker system prune -f 2>/dev/null || true
    echo -e "${GREEN}✅ Nettoyage terminé${NC}"
}

# 🏗️ Fonction de build
build_images() {
    echo -e "${BLUE}🏗️ Construction des images Docker...${NC}"
    echo -e "${CYAN}   Building Jerome's Backend...${NC}"
    docker-compose build jerome-backend
    
    echo -e "${CYAN}   Building Jerome's Frontend...${NC}"
    docker-compose build jerome-frontend
    
    echo -e "${GREEN}✅ Images construites avec succès${NC}"
}

# 🚀 Fonction de démarrage
start_services() {
    echo -e "${BLUE}🚀 Démarrage des services T4lkR...${NC}"
    
    # Démarrer la base de données en premier
    echo -e "${CYAN}   Démarrage de MongoDB (Jerome's Database)...${NC}"
    docker-compose up -d jerome-mongodb
    
    # Attendre que MongoDB soit prêt
    echo -e "${YELLOW}   Attente de MongoDB...${NC}"
    sleep 10
    
    # Démarrer Redis
    echo -e "${CYAN}   Démarrage de Redis Cache...${NC}"
    docker-compose up -d jerome-redis
    
    # Démarrer le backend
    echo -e "${CYAN}   Démarrage du Backend API...${NC}"
    docker-compose up -d jerome-backend
    
    # Attendre que le backend soit prêt
    echo -e "${YELLOW}   Attente du Backend...${NC}"
    sleep 15
    
    # Démarrer le frontend
    echo -e "${CYAN}   Démarrage du Frontend Angular...${NC}"
    docker-compose up -d jerome-frontend
    
    # Démarrer l'interface d'admin MongoDB
    echo -e "${CYAN}   Démarrage de l'interface d'administration...${NC}"
    docker-compose up -d jerome-mongo-express
    
    echo -e "${GREEN}✅ Tous les services sont démarrés !${NC}"
}

# 📊 Fonction d'affichage du statut
show_status() {
    echo -e "${BLUE}📊 Statut des services T4lkR${NC}"
    docker-compose ps
    echo ""
    
    echo -e "${PURPLE}🌐 Accès aux services :${NC}"
    echo -e "${WHITE}   • Frontend (Jerome's Interface):  ${CYAN}http://localhost:4200${NC}"
    echo -e "${WHITE}   • Backend API:                   ${CYAN}http://localhost:3000${NC}"
    echo -e "${WHITE}   • API Health Check:              ${CYAN}http://localhost:3000/api/health${NC}"
    echo -e "${WHITE}   • MongoDB Admin:                 ${CYAN}http://localhost:8081${NC}"
    echo -e "${WHITE}     └─ User: jerome / Pass: psykup25admin${NC}"
    echo ""
    
    echo -e "${YELLOW}💡 Commandes utiles :${NC}"
    echo -e "${WHITE}   • Voir les logs:        ${CYAN}docker-compose logs -f${NC}"
    echo -e "${WHITE}   • Arrêter les services: ${CYAN}docker-compose down${NC}"
    echo -e "${WHITE}   • Redémarrer:          ${CYAN}docker-compose restart${NC}"
}

# 🔍 Fonction de vérification de santé
health_check() {
    echo -e "${BLUE}🏥 Vérification de la santé des services...${NC}"
    
    # Vérifier MongoDB
    if docker-compose exec jerome-mongodb mongosh --eval "db.runCommand('ping')" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ MongoDB fonctionne${NC}"
    else
        echo -e "${RED}❌ MongoDB ne répond pas${NC}"
    fi
    
    # Vérifier le Backend
    if curl -f http://localhost:3000/api/health > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Backend API fonctionne${NC}"
    else
        echo -e "${RED}❌ Backend API ne répond pas${NC}"
    fi
    
    # Vérifier le Frontend
    if curl -f http://localhost:4200 > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Frontend fonctionne${NC}"
    else
        echo -e "${RED}❌ Frontend ne répond pas${NC}"
    fi
}

# 📋 Menu principal
main_menu() {
    echo -e "${BLUE}📋 Que souhaitez-vous faire ?${NC}"
    echo "1) 🚀 Démarrage complet (recommandé)"
    echo "2) 🏗️ Build uniquement"
    echo "3) ▶️  Démarrer les services"
    echo "4) 📊 Voir le statut"
    echo "5) 🏥 Vérification de santé"
    echo "6) 🧹 Nettoyer et redémarrer"
    echo "7) 🛑 Arrêter tous les services"
    echo "8) 📝 Voir les logs"
    echo "0) ❌ Quitter"
    echo ""
    read -p "Votre choix : " choice
    
    case $choice in
        1)
            check_requirements
            cleanup
            build_images
            start_services
            show_status
            health_check
            ;;
        2)
            check_requirements
            build_images
            ;;
        3)
            start_services
            show_status
            ;;
        4)
            show_status
            ;;
        5)
            health_check
            ;;
        6)
            cleanup
            build_images
            start_services
            show_status
            ;;
        7)
            echo -e "${YELLOW}🛑 Arrêt des services...${NC}"
            docker-compose down
            echo -e "${GREEN}✅ Services arrêtés${NC}"
            ;;
        8)
            echo -e "${BLUE}📝 Logs des services (Ctrl+C pour quitter):${NC}"
            docker-compose logs -f
            ;;
        0)
            echo -e "${PURPLE}👋 Au revoir ! Jerome serait fier du travail accompli.${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Choix invalide${NC}"
            main_menu
            ;;
    esac
}

# 🎯 Point d'entrée principal
echo -e "${WHITE}🎯 Gestionnaire T4lkR - Version Jerome${NC}"
echo -e "${CYAN}   Développé avec ❤️ en mémoire de Jerome Garnier (Psykup25)${NC}"
echo ""

# Vérifier si des arguments sont passés
if [ $# -eq 0 ]; then
    main_menu
else
    case $1 in
        "start")
            check_requirements
            cleanup
            build_images
            start_services
            show_status
            ;;
        "stop")
            docker-compose down
            ;;
        "status")
            show_status
            ;;
        "health")
            health_check
            ;;
        "logs")
            docker-compose logs -f
            ;;
        *)
            echo -e "${RED}Usage: $0 [start|stop|status|health|logs]${NC}"
            exit 1
            ;;
    esac
fi
