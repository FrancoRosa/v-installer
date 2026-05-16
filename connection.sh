#!/bin/bash

FAIL_START=0
TIMEOUT=1800   # 1800 - 30 minutes
CHECK_INTERVAL=300  #300 -  5 minutes

check_connection() {
    ping -c 1 -W 5 google.com > /dev/null 2>&1 \
    || ping -c 1 -W 5 supabase.com > /dev/null 2>&1
}

while true; do

    if check_connection; then
        echo "$(date) - Internet OK"
        FAIL_START=0

    else
        echo "$(date) - No internet"

        NOW=$(date +%s)

        if [ "$FAIL_START" -eq 0 ]; then
            FAIL_START=$NOW
            echo "Starting outage timer..."
        fi

        ELAPSED=$((NOW - FAIL_START))

        echo "Offline for $ELAPSED seconds"

        if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
            echo "$(date) - Rebooting system..."
            sudo reboot
        fi
    fi

    sleep $CHECK_INTERVAL

done