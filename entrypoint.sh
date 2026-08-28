#!/bin/bash

CONFIG_FILE="/etc/xray/config.json"

# Detect kon naa ba'y POINTED_SERVER environment variable
if [ -n "$POINTED_SERVER" ]; then
    echo "==> [MODE: POINTED SERVER ACTIVE] Routing traffic to: $POINTED_SERVER"
    sed -i "s/POINTED_SERVER_PLACEHOLDER/${POINTED_SERVER}/g" "$CONFIG_FILE"
    sed -i "s/TARGET_OUTBOUND_PLACEHOLDER/pointed-relay/g" "$CONFIG_FILE"
else
    echo "==> [MODE: NORMAL DIRECT ACTIVE] Direct routing via Cloud Run IP"
    sed -i "s/TARGET_OUTBOUND_PLACEHOLDER/direct/g" "$CONFIG_FILE"
fi

# I-start ang Xray background process ug ang Nginx
xray run -config "$CONFIG_FILE" &
nginx -g "daemon off;"
