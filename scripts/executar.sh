
#!/bin/bash

set -u

ATIVIDADE="${1:-}"

if [[ ! "$ATIVIDADE" =~ ^(0?[3-9]|10)$ ]]; then
    echo "Uso: bash executar.sh NUMERO"
    echo "Exemplo: bash executar.sh 4"
    exit 1
fi

printf -v NUMERO "%02d" "$((10#$ATIVIDADE))"

DIRETORIO="$HOME/so03_evidencias/atividade${NUMERO}"
mkdir -p "$DIRETORIO"

SCRIPT="$(dirname "$(realpath "$0")")/atividade${NUMERO}.sh"

if [[ ! -f "$SCRIPT" ]]; then
    echo "Script não encontrado: $SCRIPT"
    exit 1
fi

echo "Executando atividade $NUMERO..."
echo "Salvando saída em: $DIRETORIO/output.txt"

script -q -f -e \
    -c "bash '$SCRIPT'" \
    "$DIRETORIO/output.txt"
