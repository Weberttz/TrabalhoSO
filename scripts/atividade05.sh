#!/usr/bin/env bash
ATIV=atividade05; source "$(dirname "$0")/comum.sh"
echo 'Esta atividade cria contas/grupos e altera permissões em /temp. Execute apenas na VM de laboratório.'; read -r -p 'Digite SIM para autorizar: ' ok; [[ "$ok" == SIM ]] || exit 1
rodar grupos 'sudo groupadd -f usuarios; sudo groupadd -f alunos; getent group usuarios alunos'
rodar usuarios 'for n in 1 2 3; do id "usuario$n" >/dev/null 2>&1 || sudo useradd -m -G usuarios "usuario$n"; id "aluno$n" >/dev/null 2>&1 || sudo useradd -m -G alunos "aluno$n"; done; id usuario1; groups aluno1; getent group usuarios alunos'
manual 'Defina as senhas dos seis usuários com sudo passwd usuario1, usuario2, usuario3, aluno1, aluno2 e aluno3. Não mostre as senhas nas capturas.' senhas_definidas
rodar diretorios_permissoes 'sudo mkdir -p /temp/usuarios /temp/alunos; sudo chown root:usuarios /temp/usuarios; sudo chown root:alunos /temp/alunos; sudo chmod 770 /temp/usuarios; sudo chmod 750 /temp/alunos; sudo touch /temp/usuarios/relatorio.txt /temp/alunos/notas.txt; sudo chown root:usuarios /temp/usuarios/relatorio.txt; sudo chown root:alunos /temp/alunos/notas.txt; sudo chmod 660 /temp/usuarios/relatorio.txt; sudo chmod 640 /temp/alunos/notas.txt; ls -ld /temp/usuarios /temp/alunos; ls -l /temp/usuarios /temp/alunos'
rodar teste_usuario1 'sudo -u usuario1 bash -c '\''cd /temp/usuarios && echo teste >> relatorio.txt; echo "escrita usuarios: OK"; cd /temp/alunos && echo teste >> notas.txt'\''; sudo -u usuario1 cat /temp/alunos/notas.txt'
rodar teste_aluno1 'sudo -u aluno1 cat /temp/alunos/notas.txt; sudo -u aluno1 bash -c '\''echo teste >> /temp/alunos/notas.txt'\'''
rodar umask 'cd ~/so2026/aula03; umask; touch padrao.txt; mkdir -p padrao_dir; ls -ld padrao.txt padrao_dir; umask 027; touch restrito.txt; mkdir -p restrito_dir; ls -ld restrito.txt restrito_dir'
