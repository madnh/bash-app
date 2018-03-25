#!/usr/bin/env bash

function __module(){
    local MODULE_DIR="${1}"

    whiptail --textbox "${MODULE_DIR}/hello.txt" --scrolltext --title "File \`hello.txt\`" 12 80
}
