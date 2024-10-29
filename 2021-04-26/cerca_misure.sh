#!/bin/sh

if test ! "$#" -ne 2
then 
    echo "Uso: $0 <dir> <header>"
    exit 1
fi

dir=$1
shift
header=$2
shift

case "$dir" in
    /*) if test ! -d "$1" -o ! -x "$1"
        then
            echo "$dir non è una directory o non si hanno i permessi necessari"
            exit 2
        fi ;;
    *)  echo "$dir deve essere un percorso assoluto"
        exit 3;;
esac

PATH=$PATH:`pwd`
export PATH

echo "" > /tmp/.dir.tmp
echo "0" > /tmp/.count.tmp

sh cerca_misure_ric.sh "$dir" "$header"

cat /tmp/.dir.tmp
cat /tmp/.count.tmp