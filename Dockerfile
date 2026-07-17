FROM alpine:3.20
RUN apk update && apk add --no-cache nginx unzip ca-certificates tzdata
RUN wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v1.8.26/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && chmod +x /usr/local/bin/xray && rm -f /tmp/xray.zip
ENV PATH="/usr/local/bin:${PATH}"
COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080
CMD ["/entrypoint.sh"]
