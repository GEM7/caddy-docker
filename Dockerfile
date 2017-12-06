FROM    alpine:latest

ENV     DOMAIN  ""

RUN     buildDeps="curl unzip" && \
        set -x &&\
        mkdir -p /tmp/caddy && \
        apk add --no-cache curl unzip && \
        curl -sl -o /tmp/caddy/caddy_linux_amd64.tar.gz "https://caddyserver.com/download/linux/amd64?plugins=http.forwardproxy&license=personal" && \
        tar -zxf /tmp/caddy/caddy_linux_amd64.tar.gz -C /tmp/caddy && \
        mv /tmp/caddy/caddy /usr/bin/ && \
        chmod +x /usr/bin/caddy && \
        rm -rf /tmp/caddy && \
        apk del --purge $buildDeps

ADD     CaddyFile       /etc/Caddyfile
ADD     entrypoint.sh   /usr/local/bin

EXPOSE  443
ENTRYPOINT      ["entrypoint.sh"]
