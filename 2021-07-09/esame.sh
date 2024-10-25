#!/bin/sh

if test "$#" -lt 3
then
    echo "Numero argomenti errato - uso: $0 <nome> <anno>"
    exit 1
fi

case "$2" in
    /*) if test ! -d "$2"
        then
        echo "$2 non è una directory"
        exit 3
        fi

        if test ! -x "$2"
        then
        echo "non si hanno i permessi necessari in $2"
        exit 4
        fi;;
    
    *)  echo "$2 non è un percorso assoluto"
        exit 2;;
esac

PATH=$PATH:`pwd`
export PATH

FILELOG="$HOME"/fiumilog.txt
export FILELOG

LIVELLOMIN=/tmp/liv_min.txt
export LIVELLOMIN
echo 100000 > "$LIVELLOMIN"

GIORNOMIN=/tmp/giorno_min.txt
export GIORNOMIN
> "$GIORNOMIN"

if test -e "$FILELOG"
then
    > "$FILELOG"
fi

sh esame_ric.sh "$1" "$2"

echo "Il minimo è stato riscontrato il giorno `cat $GIORNOMIN`"
echo "Livello minimo riscontrato: `cat $LIVELLOMIN`"