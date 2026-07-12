#!/bin/sh
set -e

# ✅ Siguroha nga naay permiso
chmod +x /usr/local/bin/xray

# Sugdi ang Xray sa likod
/usr/local/bin/xray run -c /etc/xray.json &
XRAY_PID=$!

# Hulata kadiyot aron masugdan ang Xray
sleep 3

# Sugdi ang Nginx sa foreground
exec nginx -g 'daemon off;'
