#!/bin/sh

FREQ=${FREQ:-0.07}

while :; do
    COLORS=$(tac < ~/.colors | cat - ~/.colors | tr -d '#')
    for c in $COLORS; do
        CUR=$(pfw)
        test "`wattr wh $CUR`" != "`wattr wh $(lsw -r)`" && chwb -c $c $CUR
        sleep $FREQ
    done
done
