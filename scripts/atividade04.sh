#!/usr/bin/env bash
ATIV=atividade04; source "$(dirname "$0")/comum.sh"
rodar diretorio_inicial 'pwd; cd ~; pwd'
rodar criar_diretorios 'mkdir -p ~/so2026/aula03/testes; cd ~/so2026/aula03; pwd'
rodar arquivos_iniciais 'cd ~/so2026/aula03; touch arquivo1.txt arquivo2.txt; ls; ls -lha'
rodar escrita_leitura 'cd ~/so2026/aula03; echo "Sistemas Operacionais" > arquivo1.txt; echo "Estudo Dirigido 03" >> arquivo1.txt; cat arquivo1.txt; head -1 arquivo1.txt; tail -1 arquivo1.txt; wc -l arquivo1.txt'
rodar copiar_renomear 'cd ~/so2026/aula03; cp arquivo1.txt testes/; mv arquivo2.txt arquivo_renomeado.txt; ls -R; find ~ -name "arquivo*.txt"; du -sh ~/so2026'
rodar apagar_subdiretorio 'cd ~/so2026/aula03; rm testes/arquivo1.txt; rmdir testes; ls -lha'
rodar criar_links 'cd ~/so2026/aula03; ln -f arquivo1.txt ligacao_rigida.txt; ln -sfn arquivo1.txt ligacao_simbolica.txt; ls -li'
rodar remover_original 'cd ~/so2026/aula03; rm arquivo1.txt; ls -li; cat ligacao_rigida.txt; cat ligacao_simbolica.txt || true'
