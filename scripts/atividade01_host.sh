#!/usr/bin/env bash
ATIV=atividade01; source "$(dirname "$0")/comum.sh"
rodar cpu_virtualizacao 'egrep -c "(vmx|svm)" /proc/cpuinfo; lscpu | grep -i virtual'
rodar virtualbox_versao 'VBoxManage --version; VBoxManage list ostypes | head -20'
manual 'Instale VirtualBox e Extension Pack compatível. Mostre a janela Sobre/Extensões do VirtualBox.' virtualbox_extensoes
