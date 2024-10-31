#!/bin/sh

dir="$1"
shift
header="$2"
shift

cd "$dir" || exit 1

counter=0
for f in *.log
do
    if test -r "$f" -a -w "$f"
    then
        if test `head -n 1 "$f" | grep "$header"` -ge 1
        then
            echo "`pwd`/$f" >> "$HOME"/misure.txt
            counter=`expr "$counter" + 1`
        fi
    fi
done

if test counter -gt `cat /tmp/.counter.tmp`
then
    echo "$dir" > /tmp/.dir.tmp
    echo "$counter" > /tmp/.counter.tmp
done

for d in "$dir"
do
    if test -d "$d" -a -x "$d"
    then
        sh cerca_misure_ric.sh `pwd`/"$d" "$header"
    fi
done