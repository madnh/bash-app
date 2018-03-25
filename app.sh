#!/usr/bin/env bash

clear

APP_DIR=$(dirname "`realpath "$0"`")
APP_BASE_MODULE_DIR="${APP_DIR}/_"
APP_MODULE_DIR="${APP_DIR}/modules"

. "$APP_BASE_MODULE_DIR/setting.sh"
. "$APP_BASE_MODULE_DIR/functions.sh"
. "$APP_BASE_MODULE_DIR/banner.sh"
. "$APP_BASE_MODULE_DIR/init.sh"


# Main
while :
do
	_main_menu
    sleep 0.5
done

#END OF SCRIPT
