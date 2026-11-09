#!/usr/bin/env bash
ATIV=atividade09; source "$(dirname "$0")/comum.sh"
manual 'Com a VM desligada, configure Adaptador 1 NAT e Adaptador 2 host-only no VirtualBox; depois ligue a VM.' adaptadores
rodar interfaces 'ip addr show; ip route'
rodar porta_ssh 'ss -tuln | grep :22 || true; systemctl status ssh --no-pager || systemctl status sshd --no-pager || true'
rodar nmap 'if command -v nmap >/dev/null; then nmap -p 22 localhost; else echo "nmap não instalado"; fi'
manual 'NO HOSPEDEIRO: ssh-keygen -t ed25519 -C so2026; copie a chave pública com ssh-copy-id (ou manualmente no Windows). Nunca compartilhe a chave privada.' chave_publica
manual 'NO CONVIDADO: chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys; ls -ld ~/.ssh; ls -l ~/.ssh/authorized_keys (não exiba o conteúdo da chave).' permissoes_chaves
manual 'NO HOSPEDEIRO: execute ssh USUARIO@IP_HOST_ONLY, mostre o prompt remoto e hostnamectl.' conexao_ssh
manual 'NO HOSPEDEIRO: faça scp de ida e volta e uma sessão sftp; registre capturas.' transferencia_arquivos
