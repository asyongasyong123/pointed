#!/bin/sh
xray run -c /etc/xray/config.json &
sleep 2
nginx -g 'daemon off;'
