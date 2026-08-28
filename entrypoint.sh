#!/bin/sh
set -e

echo "🔧 Reading TARGET_IP from environment variable..."

# ✅ Kung walay gibutang nga IP — mag-error ug magpahibalo
if [ -z "$TARGET_IP" ]; then
  echo "⚠️ TARGET_IP not set — using default (no redirect)"
  export TARGET_IP="127.0.0.1"
else
  echo "✅ Target IP set to: $TARGET_IP"
fi

# 🔄 Ilisi ang TARGET_IP_HERE sa xray.json gamit ang value gikan sa console
sed -i "s/TARGET_IP_HERE:443/${TARGET_IP}:443/g" /etc/xray/config.json

echo "✅ Config updated — Starting services..."

# 🚀 Pagpadagan sa Nginx ug Xray
nginx -g "daemon off;" &
exec xray run -c /etc/xray/config.json
