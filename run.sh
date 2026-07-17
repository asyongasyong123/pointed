#!/bin/sh
set -e

# ✅ Sigurado nga mabasa ang variable
TARGET="${POINTED_IP:-127.0.0.1}"
echo "Forwarding to: $TARGET"

# ✅ Diretso nga pag-usab sa config
sed -i "s|\${POINTED_IP}|$TARGET|g" /etc/xray/config.json

# ✅ Sugdi ang Xray
echo "Starting Xray..."
/usr/local/bin/xray run -c /etc/xray/config.json &
sleep 5

# ✅ Sugdi ang Nginx
echo "Starting Nginx..."
exec nginx -g 'daemon off;'
