#!/bin/bash
set -e

SCPSL_DIR=/opt/scpsl
SCPSL_APP_ID=996560

echo "========================================"
echo "  SCP: Secret Laboratory Server"
echo "========================================"

# Créer les répertoires nécessaires
mkdir -p ${SCPSL_DIR}
mkdir -p /root/.steam/steam/steamapps
mkdir -p /root/.config/"SCP Secret Laboratory"

# Installation/Mise à jour via SteamCMD
if [ ! -f "${SCPSL_DIR}/LocalAdmin" ] || [ "${SKIP_UPDATE:-false}" != "true" ]; then
    echo "[INFO] Initialisation de SteamCMD..."
    steamcmd +quit || true
    
    echo "[INFO] Installation du serveur SCP:SL..."
    steamcmd \
        +force_install_dir ${SCPSL_DIR} \
        +login anonymous \
        +app_update ${SCPSL_APP_ID} validate \
        +quit
    
    echo "[INFO] Installation terminée!"
fi

# Permissions
chmod +x ${SCPSL_DIR}/LocalAdmin 2>/dev/null || true
chmod +x ${SCPSL_DIR}/SCPSL_Server.x86_64 2>/dev/null || true

# Accepter automatiquement l'EULA
CONFIG_DIR="/root/.config/SCP Secret Laboratory"
if [ ! -f "${CONFIG_DIR}/eula_accepted.txt" ]; then
    echo "[INFO] Acceptation de l'EULA..."
    echo "yes" > "${CONFIG_DIR}/eula_accepted.txt"
fi

echo "[INFO] Démarrage sur le port ${SCPSL_PORT:-7777}..."

cd ${SCPSL_DIR}
exec yes | ./LocalAdmin -p ${SCPSL_PORT:-7777}