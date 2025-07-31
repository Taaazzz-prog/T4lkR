# 💝 T4lkR Frontend Dockerfile
# En mémoire de Jerome Garnier (Psykup25)
# "Des interfaces qui touchent les cœurs"

FROM node:22-alpine

# 📋 Métadonnées en l'honneur de Jerome
LABEL maintainer="Taaazzz-prog"
LABEL description="T4lkR Angular Frontend - Jerome's UI/UX Vision"
LABEL version="1.0.0-jerome"
LABEL framework="Angular 20"
LABEL memory="Jerome Garnier (Psykup25) - Designer of Dreams"

# 🛠️ Installation des outils système nécessaires
RUN apk add --no-cache \
    curl \
    bash \
    git \
    chromium \
    && rm -rf /var/cache/apk/*

# 👤 Créer un utilisateur non-root pour la sécurité
RUN addgroup -g 1001 -S jerome && \
    adduser -S jerome -u 1001 -G jerome

# 🌐 Installer Angular CLI globalement (version exacte de Jerome)
RUN npm install -g @angular/cli@20

# 📁 Définir le répertoire de travail
WORKDIR /app

# 📦 Copier les fichiers de dépendances et installer toutes les dépendances de Jerome
COPY package*.json ./
RUN npm install && npm cache clean --force

# 📋 Copier le code source
COPY . .

# 👤 Changer la propriété des fichiers pour l'utilisateur jerome
RUN chown -R jerome:jerome /app

# 🔄 Basculer vers l'utilisateur jerome
USER jerome

# 🌐 Exposer le port Angular
EXPOSE 4201

# 🏥 Health check pour s'assurer que l'application fonctionne
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:4201 || exit 1

# 🚀 Commande de démarrage - L'interface rêvée par Jerome
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--port", "4201", "--poll", "2000"]
