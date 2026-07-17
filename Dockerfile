# Base Image
FROM alpine:3.20

# Environment Variables (Apil na ang default values)
ENV XRAY_VERSION=1.8.24
ENV POINTED_IP=127.0.0.1
ENV TZ=Asia/Manila

# I-install ang mga gikinahanglan nga pakete
RUN apk update --no-cache && apk add --no-cache \
    nginx \
    wget \
    unzip \
    ca-certificates \
    tzdata

# I-download ug i-install ang Xray
RUN wget --no-check-certificate -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    rm -rf /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# Limpyoha ang default nga Nginx config
RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/http.d/*

# Kopyaha ang imong mga file
COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh

# Ihatag ang saktong permiso
RUN chmod +x /run.sh

# I-set ang timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# I-expose ang saktong port
EXPOSE 8080

# Sugdi ang serbisyo
CMD ["/run.sh"]
