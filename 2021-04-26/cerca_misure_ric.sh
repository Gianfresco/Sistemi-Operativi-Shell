#!/bin/sh

dir=$1
shift
header=$2
shift

cd "$dir" || exit 1

counter=0
for f in *.log
do
    if test -r "$f" -a -w "$f"
    then
        if test `head -n 1 | grep "$header"` -ge 1
        then
            echo "`pwd`/$f" >> "$HOME"/misure.txt
            counter=`expr "$counter" + 1`
        fi
    fi
done

if test "$counter" -gt `cat /tmp/.count.tmp`
then
    echo "$counter" > /tmp/.count.tmp
    echo "$dir" > /tmp/.dir.tmp
fi

for d in "$dir"
do
    if test -d "$d" -a -x "$d"
    then
        sh ricerca_misure.sh `pwd`/"$d" "$header"
    fi
done