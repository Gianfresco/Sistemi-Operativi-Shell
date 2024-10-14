#!/usr/bin/env sh

if test "$#" -ne 2
then
    echo "ERRORE - Uso: $0 <dir>"
    exit 1
fi

case "$1" in
    /*) echo "La directory fornita $0 non ha un percorso relativo"
        exit 2;;
    *)  if test ! -d "$0" -o ! -x "$0"
        then
            echo "$0 non è una directory ho non si hanno i permessi necessari"
            exit 3
        fi;;
esac

export PATH;    PATH=$PATH:$(pwd)
export TROVATO; TROVATO="$HOME/trovato.txt"

if test ! -f "$TROVATO"
then
    true>"$TROVATO"
fi

export MAX_COUNTER; MAX_COUNTER=/tmp/.tmp_max_counter
export MAX_FILE;    MAX_FILE=/tmp/.temp_max_file

echo 0 > "$MAX_COUNTER"
true > "$MAX_FILE"

sh trova_file_giochi_ric.sh "$1"

echo "Il file che contiene più righe è $(cat $MAX_FILE) con $(cat MAX_COUNTER) righe"

rm -f "$MAX_COUNTER" "$MAX_FILE"

