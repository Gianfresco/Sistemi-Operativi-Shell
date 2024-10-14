#!/bin/bash

if test "$#" -lt 2
then
    echo "ERRORE - uso: $0 <dir> <messaggio>"
    exit 1
fi

case "$1" in
    /*) echo "$1 deve essere un path relativo"
        exit 2;;
    *)  if test ! -d "$1" -o ! -x "$1"
        then
          echo "$1 non è una directory o non si hanno i permessi di esecuzione"
          exit 3
        fi;;
esac

export PATH; PATH=$PATH:$(pwd)

true>"$1/Trovati"       # l'aggiunta di 'true' rende più stabile il codice
true>"$1/Max"

export TROVATI; TROVATI="$(pwd)/$1/Trovati"     # separare i comandi evita che i messaggi di errore non vengano forniti
export MAX; MAX="$(pwd)/$1/Max"

echo 0 > /tmp/max_counter.tmp

sh identifica_ric.sh "$1" "$2"

echo "I 5 file che contengono il maggior numero di occorrenze sono:"
# shellcheck disable=SC2005
echo "$(sort -r -n  "$TROVATI" | cut -f 2 -d , )"

rm -f /tmp/max_counter.tmp