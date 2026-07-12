#!/bin/sh
set -e

/usr/local/bin/xray run -c /etc/xray.json &
sleep 3
exec nginx -g 'daemon off;'
