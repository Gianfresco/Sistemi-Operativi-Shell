#!/bin/sh

cd "$2"

for i in *.txt
do
    if test -f "$i" -a -r "$i"
    then
        ris=`grep "$1" "$i" | cut -f 1,3,5 -d ,`
    fi

    if test "$ris"
    then
        echo "$ris" >> "$FILELOG"
        livello=`echo "$ris" | cut -f 1 -d ,`

        if test "$livello" -lt `cat "$LIVELLOMIN"`
        then
            echo "$livello" > "$LIVELLOMIN"
            echo "$i" > "$GIORNOMIN"
        fi
    fi
done

for dir in *
do
    if test -d "$dir" -a -x "$dir"
    then
        sh esame_ric.sh "$1" "$dir"
    fi
done