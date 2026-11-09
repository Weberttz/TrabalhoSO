#!/usr/bin/env bash
ATIV=atividade10; source "$(dirname "$0")/comum.sh"
mkdir -p "$HOME/so2026/aula03" "$HOME/so03_backups"; cd "$HOME/so03_backups" || exit 1
[[ -f ligacao_rigida.txt ]] || printf 'Sistemas Operacionais\nEstudo Dirigido 03\n' > ligacao_rigida.txt
cp ligacao_rigida.txt arquivo1.txt
rodar tar_simples 'cd ~/so03_backups; tar -cvf backup.tar /etc/passwd /etc/group'
rodar tar_gzip 'cd ~/so03_backups; tar -czvf backup.tar.gz -C ~ so2026'
rodar tar_bzip2 'cd ~/so03_backups; tar -cjvf backup.tar.bz2 -C ~ so2026'
rodar tar_listar 'cd ~/so03_backups; tar -tzvf backup.tar.gz | head -30'
rodar tar_extrair 'mkdir -p /tmp/so03_tar; tar -xzvf ~/so03_backups/backup.tar.gz -C /tmp/so03_tar | head -30'
rodar gzip 'cd ~/so2026/aula03; gzip -kf arquivo1.txt; gunzip -f arquivo1.txt.gz; cat arquivo1.txt'
rodar zip 'cd ~/so03_backups; zip -r pasta.zip ~/so2026 >/dev/null; unzip -o pasta.zip -d /tmp/restaurado >/dev/null; echo "ZIP criado e extraído"'
rodar comparar 'cd ~/so03_backups; ls -lh backup.tar backup.tar.gz backup.tar.bz2; stat -c "%n %s bytes" backup.tar backup.tar.gz backup.tar.bz2'
