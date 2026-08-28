FROM alpine:3.20

ENV XRAY_VERSION=1.8.24

RUN apk update --no-cache && apk add --no-cache \
    nginx wget unzip ca-certificates tzdata

# 📥 I-download ang Xray
RUN wget -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && rm /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# 🧹 Limpyo ang Nginx
RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/http.d/*

# 📄 Kopyaha ang tanan files
COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

# ✅ Ibutang ang permission
RUN chmod +x /entrypoint.sh

EXPOSE 8080

# 🚀 Entrypoint — mabasa ang Environment Variable!
ENTRYPOINT ["/entrypoint.sh"]
