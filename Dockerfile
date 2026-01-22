FROM steamcmd/steamcmd:ubuntu-24

ENV SCPSL_DIR=/opt/scpsl
ENV SCPSL_PORT=7777
ENV HOME=/root

# Dépendances pour SCP:SL
RUN apt-get update && \
    apt-get install -y --no-install-recommends libicu74 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p ${SCPSL_DIR} && \
    mkdir -p /root/.config/"SCP Secret Laboratory"

COPY --chmod=755 entrypoint.sh /entrypoint.sh
WORKDIR ${SCPSL_DIR}

VOLUME ["/root/.config/SCP Secret Laboratory", "/opt/scpsl"]

EXPOSE ${SCPSL_PORT}/udp

ENTRYPOINT ["/entrypoint.sh"]