#!/bin/sh
set -e

# ✅ Bag-ong variable nga ngalan
if [ -n "$POINTED_SERVER_IP" ]; then
    sed -i "s/POINTED_SERVER_IP_PLACEHOLDER/$POINTED_SERVER_IP/g" /etc/xray.json
fi

/usr/local/bin/xray run -c /etc/xray.json &
sleep 3
exec nginx -g 'daemon off;'
