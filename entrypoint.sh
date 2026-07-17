#!/bin/sh

# Susiha ang variable
if [ -z "$POINTED_IP" ]; then
  echo "ERROR: POINTED_IP variable is required"
  exit 1
fi

# I-update ang config
echo "Target set to: $POINTED_IP"
sed -i "s|\${POINTED_IP}|$POINTED_IP|g" /etc/xray/config.json

# ✅ Sugdi ang Xray una ug ayaw pag-background hangtod masiguro nga nagana
echo "Starting Xray..."
# Ipakita ang bisan unsang sayop direkta sa log
xray run -c /etc/xray/config.json > /tmp/xray.log 2>&1 &
sleep 5

# Susiha kung nagdagan
if pgrep -x "xray" > /dev/null; then
  echo "✅ Xray is running successfully"
else
  echo "❌ Xray failed to start! Error log:"
  cat /tmp/xray.log
  exit 1
fi

# Sugdi ang Nginx
echo "Starting Nginx on port 8080"
exec nginx -g 'daemon off;'
