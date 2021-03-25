#!/bin/bash
#
# Very simple script to get reproductive builds of 
#  install_thewrong-complete.zip
#
#  (c) GPL-v3 Matthias Strubel <matthias.strubel@aod-rpg.de>
#
# Needs to be place like this:
#
#      ./start_build.sh
#      ./openwrt-dev-environment    (Github Piratebox-dev/openwrt-dev-environment Development branch)
#      ./the.wrong                  (Github miyovanstenis/the.wrong)
#
#
#   The script will do a refresh of the both git repositories and then
#   execute the build process on openwrt-dev-environment.
#
#   Before using the script, make sure you are able to complete a complete build process in 
#   ./openwrt-dev-environment once
#
#   After the build is completed, the script copies all needed files together
#   out of openwrt-dev-environment and triggers the create_install_zip.sh 
#   script.
#



TARGET=ramips
TARGET_TYPE=mt76x8
INSTALL_TARGET=thewrong

CREATE_GITINFO=yes
DO_BUILD=${DO_BUILD:-yes}

WORKPATH=$(pwd)
OPENWRT_BUILT_IMAGE_PATH="$(pwd)/openwrt-dev-environment/openwrt-image-build/target_${INSTALL_TARGET}_${TARGET}-${TARGET_TYPE}"
RESULT_DIR="${WORKPATH}/the.wrong-images"

function git_last_commit(){ echo  "$1 ; " ; currdir=$(pwd) ; cd $2 ; git log -n2 --oneline  ; cd "$currdir"  ;  echo "---------" ;}

echo "Starting Build only for MT300N and Customizing The.Wrong..."
set -x -e


cd "the.wrong"
git pull
cd ..

if [ "yes" == "$DO_BUILD" ] ; then
    cd openwrt-dev-environment
    git pull
    make auto_build_development   \
            THREADS=9 \
            TARGET=${TARGET} \
            TARGET_TYPE=${TARGET_TYPE}  \
            PARCH=mipsel_24kc
fi

cd "$WORKPATH"
test -d "${RESULT_DIR}" && rm -r "${RESULT_DIR}"

cp -v "${OPENWRT_BUILT_IMAGE_PATH}/install_${INSTALL_TARGET}.zip" \
      "the.wrong/"

cd "the.wrong"

if [ "yes" == "$CREATE_GITINFO" ] ; then
    echo "Generating GIT Hash info"
    mkdir -p "additional_folders/git.info"

    git_last_commit "the.wrong" \
            "."  > "additional_folders/git.info/repository.commit.txt"
    git_last_commit "openwrt-dev-environment" \
            "${WORKPATH}/openwrt-dev-environment" >> "additional_folders/git.info/repository.commit.txt"
    git_last_commit "openwrt-image-build" \
            "${WORKPATH}/openwrt-dev-environment/openwrt-image-build" >> "additional_folders/git.info/repository.commit.txt"
    git_last_commit "PirateBoxScripts_Webserver" \
            "${WORKPATH}/openwrt-dev-environment/PirateBoxScripts_Webserver" >> "additional_folders/git.info/repository.commit.txt"
    git_last_commit "openwrt-piratebox-feed" \
            "${WORKPATH}/openwrt-dev-environment/openwrt/feeds/piratebox" >> "additional_folders/git.info/repository.commit.txt"
fi

rm -v "additional_folders/auto_flash/"* || true
mkdir -p "additional_folders/auto_flash/"
find  "${OPENWRT_BUILT_IMAGE_PATH}/" -maxdepth 1  -name *bin* -exec cp -v {} "additional_folders/auto_flash" \; 

./create_install_zip.sh


