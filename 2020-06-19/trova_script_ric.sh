#!/bin/bash

cd "$1" || exit 1

COUNTER=0
# shellcheck disable=SC2045
# shellcheck disable=SC2035
for i in $(ls *.sh 2>/dev/null)       # viene scartato l'output
do
    if test -f "$i" -a -r "$i" -a -w "$i" -a "$(grep -c "#!/bin/bash" "$i")" -gt 0
    then
        echo "$(pwd)"/"$i" >> "$LIST_FILE"
    fi
done

if test "$(cat "$MAX_HIT")" -lt $COUNTER
then
    echo "$COUNTER">"$MAX_HIT"
    echo "$(pwd)">"$MAX_DIR"
fi

# ricorsione
for dir in *
do
    if test -d "$dir" -a -x "$dir"
    then
        trova_script_ric.sh "$dir"
    fi
done