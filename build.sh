#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# SPDX-License-Identifier: GPL-3.0-or-later

CONF="${PWD}/config"
FOLDER=$(cat "${CONF}/folder")

export RELEASE_STATUS=$(cat "${CONF}/$FOLDER/release")
export USECLANG=10
export KERNEL_NAME=Fusion
export CODENAME=$(cat "${CONF}/$FOLDER/codename")
export KERNEL_VERSION=$(cat "${CONF}/$FOLDER/version")
export TYPE_KERNEL=$(cat "${CONF}/$FOLDER/type")
export PHONE="Redmi Note 7"
export DEVICES="lavender"
export CONFIG_FILE="lavender_defconfig"
export JOBS=8
export SEND_TO_HANA_CI=true
BRANCH=$(cat "${CONF}/$FOLDER/branch")

unset token
export token=${token_tele}
GIT_TOKEN=$(openssl enc -base64 -d <<< ${git_token})

git clone --depth=1 -b $BRANCH https://${git_username}:$GIT_TOKEN@github.com/${git_username2}/${git_repo2}.git saus

cd saus

wget --output-document=.kernel.sh https://raw.githubusercontent.com/alanndz/scripts/master/ci/fusion.sh

chmod +x .kernel.sh
bash ./.kernel.sh
