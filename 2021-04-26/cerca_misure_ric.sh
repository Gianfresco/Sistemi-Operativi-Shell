#!/bin/sh

dir="$1";       shift
header="$2";    shift

cd "$dir" || exit 1

counter=0
for f in *.log
do
    if test -f "$f" -a -w "$f"
    then
        if test "$(head -n 1 "$f" | grep -c "$header")" -ge 1
        then
            echo "$(pwd)"/"$f" >> "$HOME"/misure.txt
            counter=$(("$counter" + 1))
        fi
    fi
done

if test "$counter" -gt "$(cat /tmp/.counter.tmp)"
then
    echo "$dir">/tmp/.dir.tmp
    echo "$counter">/tmp/.counter.tmp
fi

for d in *
do
    if test -d "$d" -a -x "$d"
    then
        cerca_misure_ric.sh "$(pwd)"/"$d" "$header"
    fi
done