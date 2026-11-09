#!/usr/bin/env bash
ATIV=atividade06; source "$(dirname "$0")/comum.sh"
rodar ps_bsd 'ps aux | head -15'
rodar ps_unix 'ps -ef | head -15'
manual 'Abra top em OUTRO terminal, deixe os processos visíveis, volte aqui após fotografar e saia com q.' top
manual 'Abra htop em OUTRO terminal (instale caso necessário), fotografe e saia com F10.' htop
rodar pstree 'pstree -p | head -20'
echo 'Iniciando sleep 600 em segundo plano'; sleep 600 & PID=$!; jobs -l; ps aux | grep '[s]leep 600'; foto sleep_em_execucao; pausa
kill -15 "$PID"; wait "$PID" 2>/dev/null || true; rodar kill_sigterm "ps -p $PID -o pid,stat,cmd || true"
rodar servicos 'systemctl list-units --type=service --state=running | head -15; systemctl status cron --no-pager || systemctl status crond --no-pager || true'
echo 'kill -9 deve ser usado apenas se SIGTERM falhar; não mate serviços do sistema.'
