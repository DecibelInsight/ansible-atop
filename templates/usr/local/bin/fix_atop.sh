#! /usr/bin/env bash
#
# fix_atop.sh
# Copyright (C) 2016 mchristof <mchristof@ananke>
#
# Distributed under terms of the MIT license.
# {{ ansible_managed }}
#
LOCATION=/run/atop/atop.acct

function usage {
    cat << EOF
    Detect if atop file in $LOCATION has gone out of control and resets it

    usage: $0

    args:
        -h              Prints this help message and exits
        -v              Increase verbosity
EOF
}

while getopts "hv" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         v)
            VERBOSE=1;
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

#example output
#root@host:/run/atop# df -h /run/
#Filesystem      Size  Used Avail Use% Mounted on
#tmpfs           396M  3.6M  392M   1% /run
USED_SPACE=$(df -h /run/ | tr -s ' ' | tail -1 | cut -d ' ' -f5 | tr -d '%')
ATOP_SIZE_MB=$(du -sh $LOCATION  | awk '{print $1}' | cut -d '.' -f1)

[[ $VERBOSE ]] && echo "Used space [$USED_SPACE], atop size [$ATOP_SIZE_MB]"

if [[ $USED_SPACE -ge 98 ]] && [[ $ATOP_SIZE_MB -gt 100 ]]; then
    MSG="/run used space $USED_SPACE, $LOCATION size $ATOP_SIZE_MB"
    [[ $VERBOSE ]] && echo "$MSG"
    > $LOCATION
    logger -t atop "$MSG"
else
    [[ $VERBOSE ]] && echo "doing nothing"
fi
