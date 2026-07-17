# Gamit ang opisyal nga static binary image para sa Xray v1.8.26
FROM ghcr.io/xtls/xray-core:v1.8.26

# I-install lang ang Nginx ug uban pang gamit
RUN apk update && apk add --no-cache nginx ca-certificates tzdata

# Kopyaha ang imong mga files
COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

# Ihatag ang permiso
RUN chmod +x /entrypoint.sh

EXPOSE 8080

CMD ["/entrypoint.sh"]
