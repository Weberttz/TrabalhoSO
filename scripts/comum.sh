#!/usr/bin/env bash
set -u
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DISTRO="$(. /etc/os-release 2>/dev/null; printf '%s' "${ID:-host}")"
BASE="${SO03_BASE:-$HOME/so03_evidencias/$DISTRO}"
ATIV="${ATIV:-geral}"
DIR="$BASE/$ATIV"
mkdir -p "$DIR" || { echo 'ERRO: não foi possível criar diretório de evidências'; exit 1; }
CONT=0
pausa(){ if [[ -r /dev/tty ]]; then read -r -p 'Pressione ENTER para continuar... ' _ </dev/tty || true; fi; }
foto(){
 local titulo="$1" arq metodo='' status=1
 CONT=$((CONT+1))
 arq="$DIR/$(printf '%03d' "$CONT")_$(printf '%s' "$titulo" | tr ' /' '__' | tr -cd '[:alnum:]_.-').png"
 echo "Capturando tela: $titulo"
 sleep 1
 if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]]; then
   echo 'AVISO: sem sessão gráfica. Captura indisponível; saída textual preservada.'
   return 1
 fi
 if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
   if command -v gnome-screenshot >/dev/null; then gnome-screenshot -f "$arq" >/dev/null 2>&1 && status=0; metodo=gnome-screenshot; fi
   if ((status)) && command -v grim >/dev/null; then grim "$arq" >/dev/null 2>&1 && status=0; metodo=grim; fi
   if ((status)) && command -v spectacle >/dev/null; then spectacle -b -n -o "$arq" >/dev/null 2>&1 && status=0; metodo=spectacle; fi
 else
   if command -v gnome-screenshot >/dev/null; then gnome-screenshot -f "$arq" >/dev/null 2>&1 && status=0; metodo=gnome-screenshot; fi
   if ((status)) && command -v xfce4-screenshooter >/dev/null; then xfce4-screenshooter -f -s "$arq" >/dev/null 2>&1 && status=0; metodo=xfce4-screenshooter; fi
   if ((status)) && command -v scrot >/dev/null; then scrot "$arq" >/dev/null 2>&1 && status=0; metodo=scrot; fi
   if ((status)) && command -v import >/dev/null; then import -window root "$arq" >/dev/null 2>&1 && status=0; metodo=import; fi
 fi
 if ((status == 0)) && [[ -s "$arq" ]]; then echo "OK [$metodo]: $arq"; return 0; fi
 rm -f "$arq"
 echo 'AVISO: captura automática falhou. Tire uma captura manual da tela agora e salve na pasta:'
 echo "$DIR"
 return 1
}
rodar(){
 local titulo="$1" status
 shift
 printf '\n\033[1;36m### %s\033[0m\n$ %s\n' "$titulo" "$*"
 bash -c "$*" 2>&1 | tee -a "$DIR/terminal.log"
 status=${PIPESTATUS[0]}
 echo "[$titulo] código de saída: $status" | tee -a "$DIR/terminal.log"
 pausa
 return 0
}
manual(){ echo; echo "AÇÃO MANUAL: $1"; pausa; }
