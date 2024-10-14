#!/usr/bin/env sh

cd "$1" || exit 1

# ricerca tra i file .txt con diritto di lettura che contengono la stringa 'giochi' nella prima riga
for i in *.txt
do
    if test -f "$i" -a -r "$i"
    then
        if test "$(head 1 "$i")" = "giochi"
        then
            echo "$(pwd)/$i" >> "$TROVATO"
            nl=$(wc -l < "$i")
            if test "$nl" -gt "$(cat "$MAX_COUNTER")"
            then
                echo "$nl">"$MAX_COUNTER"
                echo "$(pwd)/$i">"$MAX_FILE"
            fi
        fi
    fi
done

for d in *
do
    if test -d "$d" -a -x "$d"
    then
        sh "$0" "$d"
    fi
done
