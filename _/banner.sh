#!/usr/bin/env bash

function defaultBanner() {
    echo '--------------------------'
    echo "       ${APP_NAME} ${APP_VERSION}      "
    echo '--------------------------'
}

if [ $CUSTOM_BANNER ]; then
    BANNER_FILE="${APP_DIR}/${CUSTOM_BANNER}"

    if [ -f "$BANNER_FILE" ]; then
        if [ $CUSTOM_BANNER_EXEC -eq 1 ]; then
            . $BANNER_FILE
        else
            cat "$BANNER_FILE"
        fi
    else
        defaultBanner
    fi
else
    defaultBanner
fi
