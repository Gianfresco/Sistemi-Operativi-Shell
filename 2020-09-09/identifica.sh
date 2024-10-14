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

export PATH=$PATH:$(pwd)