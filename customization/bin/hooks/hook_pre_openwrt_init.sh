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
cp -v "$pbx_cfg" "${pbx_cfg}.backup"
echo "Adjusting target directory in $pbx_cfg"
sed -i  -e 's|pb_usbdir="$ext_usbmount/PirateBox"|pb_usbdir="$ext_usbmount/the.wrong"|' "$pbx_cfg"
 
echo "Adjusting default Wifi name in $pbx_cfg" 
sed -i -e 's|pb_wireless_ssid="PirateBox - Share Freely"|pb_wireless_ssid="The.Wrong"|' "$pbx_cfg"

echo "Adjusting default hostname in $pbx_cfg"
sed -i -e 's|pb_hostname="piratebox.lan"|pb_hostname="the.wrong.lan"|' "$pbx_cfg"
uci set "system.@system[0].hostname=the.wrong.lan"

echo "Disabling random hostname generation in $pbx_cfg"
sed -i -e 's|pb_inst_flag_mesh="/etc/init.d/mesh"|pb_inst_flag_mesh="/foobar.do.not.activate"|' "$pbx_cfg" 

. "$pbx_cfg"
