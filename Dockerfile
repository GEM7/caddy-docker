FROM    alpine:latest

ENV     DOMAIN  YOUR_DOMAIN
ENV     CERT_DIR /srv/certs

RUN     buildDeps="curl unzip" && \
        set -x &&\
        mkdir -p /tmp/caddy && \
	mkdir -p /srv/caddy && \
        mkdir -p $CERT_DIR && \
        apk add --no-cache curl unzip ca-certificates && \
        curl -sl -o /tmp/caddy/caddy_linux_amd64.tar.gz "https://caddyserver.com/download/linux/amd64?plugins=http.forwardproxy&license=personal" && \
        tar -zxf /tmp/caddy/caddy_linux_amd64.tar.gz -C /tmp/caddy && \
        mv /tmp/caddy/caddy /usr/bin/ && \
        chmod +x /usr/bin/caddy && \
        rm -rf /tmp/caddy && \
        apk del --purge $buildDeps
        
VOLUME  /srv/certs
VOLUME  /root/.caddy

ADD	index.html	/srv/caddy/index.html
ADD	CaddyFile       /etc/CaddyFile

EXPOSE  443

ENTRYPOINT      ["/usr/bin/caddy"]
CMD     ["-conf", "/etc/CaddyFile"]
