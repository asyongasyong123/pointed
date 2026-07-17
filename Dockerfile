FROM alpine:3.20

# I-install ang tanang gikinahanglan + curl
RUN apk update && apk add --no-cache nginx unzip ca-certificates tzdata curl

# Gamit ang curl + opisyal nga link, mas lig-on kaysa wget
RUN curl -L --fail --insecure -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v1.8.26/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/xray.zip

ENV PATH="/usr/local/bin:${PATH}"

COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8080

CMD ["/entrypoint.sh"]
