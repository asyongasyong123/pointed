#!/bin/sh
# Ilisi ang variable sa sulod sa config
sed -i "s|env:POINTED_IP|${POINTED_IP}|g" /etc/xray/config.json
# Sugdi ang Xray
xray run -c /etc/xray/config.json &
sleep 2
nginx -g 'daemon off;'
