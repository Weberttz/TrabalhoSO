#!/usr/bin/env bash
ATIV=atividade02; source "$(dirname "$0")/comum.sh"
rodar maquinas 'VBoxManage list vms'
rodar detalhes_vms 'VBoxManage list vms; VBoxManage list snapshots "${VM1:-NOME_VM1}" 2>&1; VBoxManage list snapshots "${VM2:-NOME_VM2}" 2>&1'
manual 'Abra a janela principal do VirtualBox mostrando AS DUAS VMs e seus nomes obrigatórios.' duas_vms
manual 'Confira que o snapshot instalacao_limpa foi criado em cada VM.' snapshots
