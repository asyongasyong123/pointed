FROM alpine:latest

# Install Nginx, Xray-core, ug kinahanglanong tools
RUN apk add --no-cache ca-certificates curl bash nginx && \
    mkdir -p /etc/xray /var/log/nginx /run/nginx && \
    curl -L -s https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ xray && \
    chmod +x /usr/local/bin/xray && \
    rm -f /tmp/xray.zip

# I-copy ang config files ug entrypoint
COPY nginx.conf /etc/nginx/nginx.conf
COPY xray.json /etc/xray/config.json
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
