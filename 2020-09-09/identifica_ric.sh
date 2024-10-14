#!/usr/bin/env sh

cd "$1" || exit 1

for i in *
do
    if test -f "$i" -a -r "$i"
    then
        mc=$(grep -c "$2" "$i")     # message counter
        if test "$mc" -gt 0
        then
            echo "$mc, $(pwd)/$i" >> "$TROVATI"
        fi

        if test "$mc" -gt "$(cat /tmp/max_counter.tmp)"
        then
            echo "$mc" > /tmp/max_counter.tmp
            echo "$(pwd)/$i" > "$MAX"
        fi
    fi
done

for d in *
do
    if test -d "$d" -a -x "$d"
    then
        sh "$0" "$d" "$2"
    fi
done