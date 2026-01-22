#!/bin/bash
set -e

SCPSL_DIR=/opt/scpsl
SCPSL_APP_ID=996560

echo "========================================"
echo "  SCP: Secret Laboratory Server"
echo "========================================"

# Installation/Mise à jour via SteamCMD
if [ ! -f "${SCPSL_DIR}/LocalAdmin" ] || [ "${SKIP_UPDATE:-false}" != "true" ]; then
    echo "[INFO] Installation/Mise à jour via SteamCMD..."
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

echo "[INFO] Démarrage sur le port ${SCPSL_PORT:-7777}..."

cd ${SCPSL_DIR}
exec ./LocalAdmin -p ${SCPSL_PORT:-7777}