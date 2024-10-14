#!/bin/bash

cd "$1" || return 

COUNTER=0

for i in *.bak
do
    if test -f $i -a -r $i -a "&(head -n 1 $i | grep -c $3)" -gt 0
    then
        cp $i "$2"
        # COUNTER=$(expr "$COUNTER" + 1) --- antiquato
        COUNTER="$(("$COUNTER" + 1))"
    fi
done

if test "$(cat "$MAX_HIT")" -lt "$COUNTER"
then
    echo "$COUNTER">"$MAX_HIT"
    "$(pwd)">"$MAX_DIR"
    echo "$MAX_DIR"
fi

TOT=$(cat "$TOTALE")
# "$(expr "$TOT" + "$COUNTER")">"$TOTALE" --- antiquato
"$(("$TOT" + "$COUNTER"))">"$TOTALE"
echo "$TOTALE"

for dir in *
do
    if test -d "$dir" -a -x "$dir"
    then
        $0 "$dir" "$2" "$3"
    fi
done