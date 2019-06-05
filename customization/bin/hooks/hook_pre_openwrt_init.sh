#!/bin/sh

# ---- TEMPLATE ----

# Hook for modifcation stuff before 
#          piratebox/bin/install  ... openwrt 
# is started


if [ !  -f $1 ] ; then 
  echo "Config-File $1 not found..." 
  exit 255
fi

#Load config
. $1 

#Load openwrt-common config and procedures file!
. /etc/piratebox.config


# You can uncommend this line to see when hook is starting:
echo "------------------ Running $0 ------------------"

pbx_cfg="/etc/piratebox.config"

echo "Backup $pbx_cfg"


# Load configuration
. /etc/ext.config
. $ext_linktarget/etc/piratebox.config

# Load function libraries
. $ext_linktarget/usr/share/piratebox/piratebox.common


uci set "system.@system[0].hostname=the.wrong.lan"

# AP Client Isolation
uci set wireless.@wifi-iface[0].isolate='1'

pb_setSSID "The.Wrong"
uci commit

