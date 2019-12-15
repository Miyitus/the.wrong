#!/bin/sh

# ---- TEMPLATE ----

# Runs on every Startup
#  get config file 

if [ !  -f $1 ] ; then
  echo "Config-File $1 not found..."
  exit 255
fi

#Load config
. $1

# You can uncommend this line to see when hook is starting:
 echo "------------------ Running $0 ------------------"

if test -e "${SHARE_FOLDER}/access.log" && test -s "${SHARE_FOLDER}/access.log"  ; then
    echo "Rotating access.log"
    access_count=$( ls -1 ${SHARE_FOLDER}/access.log* | wc -l )
    mv -v  "${SHARE_FOLDER}/access.log" "${SHARE_FOLDER}/access.log.${access_count}"
fi

