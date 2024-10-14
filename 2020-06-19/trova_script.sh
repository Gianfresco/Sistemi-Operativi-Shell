#!/bin/bash

# USO: trova_script <dir>
if test $# -ne 1                    # se "numero argomenti" != 1
then
    echo "ERRORE - uso: $0 <dir>"
    exit 1
fi

case $1 in
    /*) if test ! -d "$1" -o ! -x "$1"  # se $1 non è una dir OR $1 non è accessibile
        then
          echo "$1 non è una directory o non si hanno i diritti di accesso"
          exit 2
        fi;;
    *)  echo "$1 non è un path assoluto"    # se $1 non inizia con '/'
        exit 3;;
esac

LIST_FILE=$HOME/script.txt; export LIST_FILE    # 'export' rende disponibile la variabile a tutti i processi figli
touch "$LIST_FILE"

PATH=$PATH:$(pwd)
export PATH

MAX_DIR=/tmp/.maxDir; export MAX_DIR>"$MAX_DIR" # sarebbe 'export MAX_DIR; >"$MAX_DIR" ma dà errori'
MAX_HIT=/tmp/.maxHit; export MAX_HIT>"$MAX_HIT"; echo $MAX_HIT
trova_script_ric.sh "$1"

echo "La directory contenente il maggior numero di script è $(cat "$MAX_DIR") con $("$MAX_HIT") occorrenze"
rm $MAX_HIT $MAX_DIR
