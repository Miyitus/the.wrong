#!/bin/sh

# ---- TEMPLATE ----

# Hook for modifcation stuff right after
#          piratebox/bin/install  ... part2 
# is run.

if [ !  -f $1 ] ; then
  echo "Config-File $1 not found..."
  exit 255
fi

#Load config
. $1

# You can uncommend this line to see when hook is starting:
echo "------------------ Running $0 ------------------"

echo "Switching hostname to $HOST"
/opt/piratebox/bin/install_piratebox.sh hostname "$HOST"

echo "Enabling Auto-Configuration via TXT files"
cd /opt/autocfg/modules.enabled 
ln -s ../modules.available/12_openwrt_channel.sh .
ln -s ../modules.available/10_openwrt_ssid.sh  .
ln -s ../modules.available/11_openwrt_txpower.sh   .
ln -s ../modules.available/50_piratebox_hostname.sh    .

cd -
