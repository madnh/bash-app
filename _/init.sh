#!/usr/bin/env bash

# Init application, can be use to check requirement

echo 'Initing...'

EXITSTATUS=$(which lsb_release &>/dev/null; echo $?)
if [[ $EXITSTATUS != 0 ]]; then
    _message error "\aCan't check which distribution you are using! Aborting."
    _message error " Aborting..."
else
    _message info 'Current distribution is: '$(lsb_release -ds)
fi
