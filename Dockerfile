FROM alpine:3.20 AS xray-bin
RUN apk add --no-cache curl unzip ca-certificates bash
WORKDIR /app
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o xray.zip \
    && unzip xray.zip \
    && chmod +x xray \
    && mv xray /usr/local/bin/xray \
    && rm -rf xray.zip

FROM nginx:1.25-alpine
RUN apk add --no-cache ca-certificates bash tzdata
COPY --from=xray-bin /usr/local/bin/xray /usr/local/bin/xray

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json /etc/xray.json
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/local/bin/xray /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
