#!/bin/sh
# I-replace ang env variable sa config
sed -i "s|env:POINTED_IP|${POINTED_IP}|g" /etc/xray/config.json

# Ipakita kung sakto ang target para masusi
echo "✅ Forwarding to target: ${POINTED_IP}:80"

# Sugdi ang Xray sa background
xray run -c /etc/xray/config.json &

# Paghulat gamay para andam na ang Xray
sleep 3

# Sugdi ang Nginx sa foreground
exec nginx -g 'daemon off;'
