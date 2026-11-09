#!/usr/bin/env bash
ATIV=atividade11; source "$(dirname "$0")/comum.sh"
rodar identificacao 'cat /etc/os-release; uname -r; hostnamectl'
rodar pacotes_servicos 'command -v apt || true; command -v dnf || true; command -v zypper || true; command -v pacman || true; systemctl list-unit-files | grep -E "^(ssh|sshd|cron|crond|atd)\.service" || true'
rodar ambiente_recursos 'echo "DESKTOP=$XDG_CURRENT_DESKTOP"; free -h; df -h /; systemd-analyze time || true'
rodar arquivos_obrigatorios 'cat /etc/passwd; cat /etc/group'
