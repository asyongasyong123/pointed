#!/bin/sh
sed -i "s|env:POINTED_IP|${POINTED_IP}|g" /etc/xray.json
/usr/local/bin/xray run -c /etc/xray.json &
sleep 3
exec /usr/local/openresty/bin/openresty -g 'daemon off;'
