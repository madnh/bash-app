#!/usr/bin/env bash

# Echo message to console
# Params:
#       <color> Can be: title, error, info, warning, question, success, header
#       <message>
#
function _message(){
	local color=$1;
	local exp=$2;

	if ! [[ $color =~ '^[0-9]$' ]] ; then
		case $(echo -e $color | tr '[:upper:]' '[:lower:]') in
			# 0 = black
			title) color=0 ;;
			# 1 = red
			error) color=1 ;;
			# 2 = green
			info) color=2 ;;
			# 3 = yellow
			warning) color=3 ;;
			# 4 = blue
			question) color=4 ;;
			# 5 = magenta
			success) color=5 ;;
			# 6 = cyan
			header) color=6 ;;
			# 7 = white
			*) color=7 ;;
		esac
	fi
	tput bold;
	tput setaf $color;
	echo $exp;
	tput sgr0;
}

# Show main menu
function _main_menu {
    _message title "Show main menu..."

    MODULE=$(eval whiptail --notags \
            --title \"${APP_NAME} ${APP_VERSION}\" \
            --backtitle \"${APP_NAME} ${APP_VERSION}\" \
            --ok-button \"Do it\" \
            --cancel-button \"Quit\" \
            --menu \"\\nWhat would you like to do?\" \
            0 0 0 \
            $(cat "${APP_DIR}/_menu.txt") \
            3>&1 1>&2 2>&3)

	# check exit status
	EXITSTATUS=$?
	if [ $EXITSTATUS = 0 ]; then
		_call_module "${MODULE}"
	else
		_quit
	fi
}

# Call module. By default return to main menu after module execute complete
# Params:
#       <module name>
#
function _call_module() {
    local moduleName="$1"
    local moduleDir="${APP_MODULE_DIR}/${moduleName}"

    echo
    _message title "Starting '${moduleName}' module..."

    echo
    echo '--------------------------------'
    echo "    Module: ${moduleName}"
    echo '--------------------------------'
    echo
    # Require module file
    . "${moduleDir}/${moduleName}.sh"

    # Call module
    "__module" "${moduleDir}/"

    echo
    echo '--------------------------------'
    _message info "Call '${moduleName}' module complete"

    _main_menu
}

# Show confirm dialog to quit. If not quit then return to main menu
# Params:
#     [<addition message> '']
#
function _confirm_to_quit {
    local addition_message="${1:-}"

    if ! [ -z "${addition_message}" ]; then
        addition_message="${addition_message}\n"
    fi

	_message title "Quiting..."

    if (_confirm "${addition_message}Are you sure you want quit?" "Quit" "Yes" "No") then
		_quit
	else
		_main_menu
	fi
}

# Quit, write quit message to console
function _quit {
    echo
    echo "Exiting..."
    echo
    _message success 'Thanks for using!'
    echo
    exit 0
}

# Show confirm dialog to ask to back to main menu or exit
# Params: no params
#
function _ask_back_to_main_menu {
    if (_confirm "Do you want to go back to the main menu or exit?" "Confirm" "Main menu" "Exit") then
        _main_menu
    else
        _quit
    fi
}

# Show confirm dialog
# Params: \
#       [<message> Are you sure you want to do it?]
#       [<title> Confirm]
#       [<yes button> Yes]
#       [<no button> No]
#
function _confirm {
    local confirm_message="${1:- Are you sure you want to do it?}"
    local confirm_title="${2:-Confirm}"
    local yes_btn="${3:-Yes}"
    local no_btn="${4:-No}"

	if (whiptail --title "${confirm_title}" --yesno "${confirm_message}" --yes-button "${yes_btn}" --no-button "${no_btn}" 0 0) then
        return 0
    else
        return 1
    fi
}

# Show alert dialog
function _alert {
    local alert_message="${1}"
    local alert_title="${2:-Info}"

    whiptail --title "${alert_title}" --msgbox "${alert_message}" 0 0
}

# Wait to user press any key to continue
# Params:
#       [<message> Press any key to continue]
#
function _pause {
    local message="${1:-Press any key to continue}"

    echo
    echo
    read -n 1 -s -r -p "${message}"
    echo
}
