#!/usr/bin/env bash
ATIV=atividade03; source "$(dirname "$0")/comum.sh"
for cmd in 'uname -a' 'uname -r' 'cat /etc/os-release' 'hostnamectl' 'lscpu' 'lsblk' 'free -h' 'df -h' 'uptime'; do rodar "$(echo "$cmd" | tr ' /' '__')" "$cmd"; done
