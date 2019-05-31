#!/bin/bash
#
#  Project: the.wrong
#  Description:   
#     The script will take a regular PirateBox install.zip file,
#     and add needed changes to the piratebox_ws_*.img.tar.gz file.
#     Afterwards, it will repackage a new zip file.
#
#  Needed things
#     sudo to perform mount & umount
#     losetup tools
#
#    (c)2019 Matthias Strubel   - matthias.strubel@aod-rpg.de
set -e 

PROJECT_NAME="the.Wrong"
BASE_IMAGE_NAME="piratebox_ws_1.2_img.tar.gz"
BASE_IMAGE_EXTR="image_stuff/piratebox_img"

work_path=$(pwd)


function perform_sudo_command(){
 
    set -x
    sudo $*
    set +x

}


function do_removals(){
    local pbx=$1; shift


    perform_sudo_command rm -rv "${pbx}/www_content/"


}


function do_changes(){
   local patches=$1 ; shift
   local pbx=$1 ; shift
   
   echo "Doing adjustments in default configuration"

   perform_sudo_command patch -t -i "${patches}/lighttpd.conf.1.patch" "${pbx}/conf/lighttpd/lighttpd.conf"

   echo "NOTHING HERE CURRENTLY"

}

function do_dynamic_content(){
   local pbx=$1 ; shift
   local dst=$1 ; shift

   mkdir -p "$dst"

   # Create a version tag
   cp -v  "$pbx/version" "$dst/version"
   echo "######  $PROJECT_NAME   #####" >>  "$dst/version"
   git status -sb --porcelain   >> "$dst/version"
   git log  -n2  --oneline >> "$dst/version"

}

function do_image_file(){
    local img_file=$1 ; shift
    local tmp_folder=$1 ;shift
    local src_customization=$1; shift
    local src_patches=$1; shift

    img_mount="$tmp_folder/mount"

    if ! test -f "$img_file" ; then
	echo "Error: $BASE_IMAGE_NAME  not found in zip file ($img_file)"
	exit 16
    fi

    if test -d "$img_mount" ; then
   	if mount | grep -q "$img_mount" ; then
		echo "ERROR $img_mount still mounted, please clean mountpoint"
		exit 16
	fi
    fi
    mkdir -p "$img_mount"

    test -f  "$tmp_folder/$BASE_IMAGE_EXTR" && rm  "$tmp_folder/$BASE_IMAGE_EXTR"
    tar xzf "$img_file"  -C "$tmp_folder"

    echo "Perform mount of the image file"
    perform_sudo_command mount -o loop,rw "$tmp_folder/$BASE_IMAGE_EXTR" "$img_mount"

    echo "Creating dynamic source content"
    do_dynamic_content  "$img_mount" "$tmp_folder/dynamics"

    echo "Removing existing content"
    do_removals         "$img_mount"


    echo "Copy content"
    perform_sudo_command cp -vr "${src_customization}/*" "$img_mount"
    echo "Copy generated content"
    perform_sudo_command cp -vr "${tmp_folder}/dynamics/*" "$img_mount"

    echo "Change configuration"
    do_changes "$src_patches"  "$img_mount"

    echo "Umounting img file"
    perform_sudo_command umount "$img_mount"
}

function do_install_zip(){
    local src_zip=$1 ; shift
    local tmp_folder=$1 ;shift
    local src_customization=$1; shift
    local src_patches=$1; shift
    local dst_zip_name=$1; shift

    if ! test -f "$src_zip" ; then
	echo "INSTALL ZIP '$src_zip' is missing"
	exit 16
    fi
    if ! test -d "$src_customization" ; then
        echo "Customization folder '$src_customization' is missing"
        exit 16
    fi
    if ! test -d "$src_patches" ; then
        echo "Patches folder '$src_patches' is missing"
        exit 16
    fi

    test -d "$tmp_folder/install" && rm -r "$tmp_folder/install" 

    unzip "$src_zip" -d "$tmp_folder"
    image_file_path="$tmp_folder/install/$BASE_IMAGE_NAME" 

    do_image_file "$image_file_path" \
                  "$tmp_folder" \
                  "$src_customization" \
                  "$src_patches" 

    echo "Zip into $dst_zip_name"
    cd "$tmp_folder"
    zip -r9 "$dst_zip_name" "./install" 
 
}






do_install_zip   "./install_piratebox.zip"  \
                 "./tmp_zip" \
                 "./customization" \
                 "./patches" \
                 "./install_the.wrong.zip"

