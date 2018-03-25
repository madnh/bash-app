#!/usr/bin/env bash

function __module() {
    local MODULE_DIR="${1}"
    local MODULE_NAME=$(whiptail --inputbox "Module name?" 8 78 --title "Create module" 3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        local MODULE_FILE="${APP_MODULE_DIR}/${MODULE_NAME}/${MODULE_NAME}.sh"

        mkdir "${APP_MODULE_DIR}/${MODULE_NAME}";
        cp "${MODULE_DIR}/data/template.sh" "${MODULE_FILE}";
        chmod +x "${MODULE_FILE}";

        _message success "Create module success"
    fi
}
