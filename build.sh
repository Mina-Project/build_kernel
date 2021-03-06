#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2020 @MoveAngel (Telegram and GitHub)
# SPDX-License-Identifier: GPL-3.0-or-later

CONF="${PWD}/config"
FOLDER=$(cat "${CONF}/folder")
PATCHES="${PWD}/patches"

export RELEASE_STATUS=$(cat "${CONF}/release")
export KERNEL_NAME="Mina-Kernel"
export CODENAME=$(cat "${CONF}/$FOLDER/codename")
export RELEASE_VERSION=$(cat "${CONF}/$FOLDER/version")
export KERNEL_TYPE=$(cat "${CONF}/$FOLDER/type")
export PHONE="Redmi Note 7/7S"
export DEVICES="lavender"
export CONFIG_FILE="lavender_defconfig"
export COMPILER_IS_CLANG=true
export USECLANG="proton-11"
export USEGCC=93
export CHAT_ID=$(openssl enc -base64 -d <<< LTEwMDEzMjM5ODMyMjY=)
export DEVELOPER="MoveAngel"
export HOST="SatapimNoob"
export AK_BRANCH="master"
export JOBS=8
BRANCH=$(cat "${CONF}/$FOLDER/branch")

unset token
export token=$(openssl enc -base64 -d <<< MTI5MDc5MjQxNDpBQUY4QWJQVWc4QkpQcG5rVjhLTUV5ZW5FNnlZeW1od0ljZw==)
GIT_TOKEN=$(openssl enc -base64 -d <<< YTBmZDMwY2Y0N2ExMTg5ZjUyYmExZjgzYTBmZjhmMjNiMWVlNDM0Nw==)
git clone --depth=1 -b $BRANCH https://MoveAngel:$GIT_TOKEN@github.com/Mina-Project/kernel_xiaomi_lavender.git saus

cd saus

RESET_COMMIT=$(git --no-pager log --pretty=format:'%h')

wget --output-document=.kernel.sh https://raw.githubusercontent.com/Mina-Project/scripts/master/lavender/global.sh

# Build first Kernel

chmod +x .kernel.sh
bash ./.kernel.sh

# reset kernel to HEAD
#
#make -C "${PWD}/.ToolBuild/AnyKernel3" clean &>/dev/null
#export CODENAME="$(cat "${CONF}/$FOLDER/codename")-Old_CAM"
#git am "${PATCHES}/01.patch"
#bash ./.kernel.sh
# detect wen compile failed
if [ ! -f ".Output/arch/arm64/boot/Image.gz-dtb" ]; then
    exit
fi

# Build second kernel for camera patch
#git reset --hard $RESET_COMMIT
#export CODENAME="$(cat "${CONF}/$FOLDER/codename")-New_CAM"
#make -C "${PWD}/.ToolBuild/AnyKernel3" clean &>/dev/null

# Patching kernel for new patch
# curl https://github.com/MiCode/Xiaomi_Kernel_OpenSource/commit/cf2a90f96348c6a3142d53ca209983da18c72410.patch | git am
#git am "${PATCHES}/02.patch"
#bash ./.kernel.sh
