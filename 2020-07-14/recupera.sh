#!/bin/bash

if test $# -ne 3; then
    echo "Uso: <dir> <recuperati> <titolo>"
    exit 1
fi

case $1 in
/*)
    if test ! -d "$1"; then
        echo "$1 non è una directory"
        exit 2
    fi
    if test ! -x "$1"; then
        echo "$1 non è eseguibile"
        exit 3
    fi
    ;;

*)
    echo "$1 non è un path assoluto"
    exit 3
    ;;
esac

case $2 in
/*) ;;
*)
    echo "$2 non è un path assoluto"
    exit 4
    ;;
esac

if test ! -d "$2"; then
    mkdir "$2"
fi

PATH=$PATH:"$(pwd)"
export PATH
MAX_DIR=/tmp/.maxDir
export MAX_DIR>$MAX_DIR
MAX_HIT=/tmp/.maxHit
export MAX_HIT
echo 0 >$MAX_HIT
TOTALE=/tmp/.totale
export TOTALE
echo 0 >$TOTALE

recupera_ric.sh "$1" "$2" "$3"

echo "la directory contente il maggior numero di file ripristinati è $(head -1 /tmp/.maxDir) con $(cat /tmp/.maxHit) occorrenze totali"

echo "sono stati spostati $(cat $TOTALE) files"

rm $MAX_DIR $MAX_HIT