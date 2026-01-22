FROM steamcmd/steamcmd:ubuntu-24

ENV SCPSL_DIR=/opt/scpsl
ENV SCPSL_PORT=7777

# Dépendances pour SCP:SL + création utilisateur
RUN apt-get update && \
    apt-get install -y --no-install-recommends libicu74 && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -s /bin/bash steam && \
    mkdir -p ${SCPSL_DIR} && \
    mkdir -p /home/steam/.config/"SCP Secret Laboratory" && \
    chown -R steam:steam ${SCPSL_DIR} /home/steam

COPY --chmod=755 entrypoint.sh /entrypoint.sh

USER steam
WORKDIR ${SCPSL_DIR}

VOLUME ["/home/steam/.config/SCP Secret Laboratory", "/opt/scpsl"]

EXPOSE ${SCPSL_PORT}/udp

ENTRYPOINT ["/entrypoint.sh"]