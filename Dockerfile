FROM    alpine:latest

ENV     DOMAIN	""	
ENV     CERT_DIR	/srv/docker/certs
ENV	WEB_DIR		/srv/docker/caddy

ADD	CaddyFile	/etc/CaddyFile


RUN     buildDeps="curl unzip" && \
        set -x &&\
        mkdir -p /tmp/caddy && \
	mkdir -p $WEB_DIR && \
        mkdir -p $CERT_DIR && \
        apk add --no-cache curl unzip ca-certificates && \
        curl -sl -o /tmp/caddy/caddy_linux_amd64.tar.gz "https://caddyserver.com/download/linux/amd64?plugins=http.forwardproxy&license=personal" && \
        tar -zxf /tmp/caddy/caddy_linux_amd64.tar.gz -C /tmp/caddy && \
        mv /tmp/caddy/caddy /usr/bin/ && \
        chmod +x /usr/bin/caddy && \
        rm -rf /tmp/caddy && \
        apk del --purge $buildDeps
        
VOLUME  /srv/docker/certs
VOLUME	/srv/docker/caddy

ADD	index.html	$WEB_DIR/index.html

EXPOSE  443

ENTRYPOINT	sed -i "s#DOMAIN#$DOMAIN#g" /etc/CaddyFile && \
		sed -i "s#CERT_DIR#$CERT_DIR#g" /etc/CaddyFile && \
		/usr/bin/caddy -conf /etc/CaddyFile
#CMD     ["-conf", "/etc/CaddyFile"]
