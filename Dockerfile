FROM alpine:3.20

RUN apk add --no-cache nginx ca-certificates bash tzdata

COPY xray /usr/local/bin/xray
RUN chmod +x /usr/local/bin/xray

COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
CMD ["/entrypoint.sh"]
