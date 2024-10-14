#!/usr/bin/env sh

if test "$#" -lt 3
then
    echo "ERRORE - Uso: $0 <dir> <header>"
    exit 1
fi

dir="$1";       shift
header="$2";   shift

case "$dir" in
    /*) ;;
    *)  echo "<dir> deve essere un percorso assoluto"
        exit 2;;
esac

if test ! -d "$dir"
then
    echo "Errore: $dir non è una directory"
    exit 3
fi

if test ! -x "$dir"
then
    echo "Errore: non è posissibile eseguire $dir"
    exit 4
fi

PATH=$PATH:$(pwd)
export PATH

echo "" > /tmp/.dir.tmp
echo "0" > /tmp/.counter.tmp
echo "" > "$HOME"/misure.txt

sh cerca_misure_ric.sh "$dir" "$header"

cat /tmp/.dir.tmp
cat /tmp/.counter.tmp

rm -f /tmp/.dir.tmp /tmp/.counter.tmp