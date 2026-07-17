#!/bin/sh
set -e

# Susiha kung naa ang target variable
if [ -z "$POINTED_IP" ]; then
  echo "ERROR: POINTED_IP variable is required"
  exit 1
fi

# I-update ang Xray config
echo "Target set to: $POINTED_IP"
sed -i "s|\${POINTED_IP}|$POINTED_IP|g" /etc/xray/config.json

# Sugdi ang Xray
echo "Starting Xray..."
xray run -c /etc/xray/config.json &
XRAY_PID=$!

# Paghulat ug kumpirmahi nga nagdagan na
sleep 4
if ps -p $XRAY_PID > /dev/null; then
  echo "Xray running on ports 10001-10008"
else
  echo "ERROR: Xray failed to start"
  exit 1
fi

# Sugdi ang Nginx
echo "Starting Nginx on port 8080"
exec nginx -g 'daemon off;'
