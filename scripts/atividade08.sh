#!/usr/bin/env bash
ATIV=atividade08; source "$(dirname "$0")/comum.sh"
command -v crontab >/dev/null || { echo 'Instale cron/cronie primeiro'; exit 1; }
rodar cron_instalar '(crontab -l 2>/dev/null | grep -v "# SO03_AUTO"; echo "*/5 * * * * /usr/bin/uptime >> $HOME/carga.log 2>&1 # SO03_AUTO") | crontab -; crontab -l'
manual 'Aguarde pelo menos 10 minutos com a VM ligada; depois verifique o arquivo carga.log.' cron_aguardado
rodar cron_log 'cat ~/carga.log'
if command -v at >/dev/null; then rodar at_agendar 'echo "echo tarefa executada >> /tmp/at.log" | at now + 2 minutes; atq'; manual 'Aguarde 2 minutos e confira o agendamento.' at_aguardado; rodar at_resultado 'cat /tmp/at.log'; else echo 'Instale at e habilite atd (sudo systemctl enable --now atd), depois execute esta etapa novamente.'; fi
