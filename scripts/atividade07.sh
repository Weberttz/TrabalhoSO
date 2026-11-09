#!/usr/bin/env bash
ATIV=atividade07; source "$(dirname "$0")/comum.sh"
for cmd in 'free -m' 'free -h' 'df -h' 'df -i' 'du -sh /var/log' 'du -h --max-depth=1 /var | sort -h' 'vmstat 1 5' 'swapon --show' 'cat /proc/meminfo | head -10' 'lsblk -f'; do rodar "$(echo "$cmd" | tr ' /|' '___')" "$cmd"; done
