#!/usr/bin/bash
set -euo pipefail

BASE_PATH="/opt/containers/traefik-crowdsec-stack"
BASE_TRAEFIK_CROWDSEC_STACK=(/opt/containers/traefik-crowdsec-stack/{traefik,crowdsec/{config,data},config})

# Hauptverzeichnis erstellen und zusätzliche Unterordner in 'crowdsec' erstellen wenn noch nicht vorhaden...
[ ! -d "$BASE_PATH" ] && mkdir -p "${BASE_TRAEFIK_CROWDSEC_STACK[@]}"

# Ins Hauptverzeichnis wechseln
cd "$BASE_PATH"

# .env Datei im Hauptverzeichnis erstellen
touch "$BASE_PATH"/.env

# Umgebungsspezifische .env Dateien in 'config' erstellen
touch "$BASE_PATH"/config/{crowdsec.env,traefik.env,traefik-crowdsec-bouncer.env}

# Zusätzliche Dateien in 'traefik' erstellen und Zugriffsrechte für bestimmte Dateien festlegen
touch "$BASE_PATH"/traefik/{acme_letsencrypt.json,traefik.yml,dynamic_conf.yml,tls_letsencrypt.json}
chmod 600 "$BASE_PATH"/traefik/{acme_letsencrypt.json,tls_letsencrypt.json}

# install tree
sudo dpkg -l | grep -qw tree || sudo apt-get install tree
tree -L 2 -a "$BASE_PATH"

