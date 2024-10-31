#!/bin/sh

dir="$1"
shift
header="$2"
shift

if test ! "$#" -lt 2
then
    echo "Uso: $0 <dir> <header>"
    exit 1
fi

case "$dir" in
    /*) if test ! -d "$dir" -o ! -x "$dir"
        then
            echo "$dir non è una caretlla o non si hanno i permessi necessari"
            exit 2
        fi;;
    *)  echo "$dir non è un percorso assoluto"
        exit 3;;
esac

PATH="$PATH":`pwd`
export PATH

echo "" > /tmp/.dir.tmp
echo "0" > /tmp/.counter.tmp

sh cerca_misure_ric.sh "$dir" "$header"

cat /tmp/.dir.tmp
cat /tmp/.counter.tmp
