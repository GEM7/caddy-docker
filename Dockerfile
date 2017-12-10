FROM    alpine:latest

LABEL	maintainer	Adam	github.com/GEM7/caddy-docker

ENV     PATH=/usr/local/bin/:$PATH \
	CADDY_DL="https://caddyserver.com/download/linux/amd64?plugins=http.filemanager,http.forwardproxy&license=personal" \
	DOMAIN="" \
	CERT_DIR=/srv/docker/certs \
	WEB_DIR=/srv/docker/caddy \
	FILE_PATH=/share \
	FILE_USER=Admin \
	FILE_PASS=Administrator \
	PROXY_USER=HTTP2proxy \
	PROXY_PASS=http2PROXY
		

ADD	CaddyFile	/etc/CaddyFile
ADD	index.html	$WEB_DIR/index.html
ADD	entrypoint.sh	/usr/local/bin

RUN     buildDeps="curl unzip" && \
        set -x &&\
	mkdir -p $WEB_DIR && \
	mkdir -p $WEB_DIR$FILE_PATH	&& \
        mkdir -p $CERT_DIR && \
        mkdir -p /tmp/caddy && \
        apk add --no-cache $buildDeps ca-certificates && \
        curl -sl -o /tmp/caddy/caddy_linux_amd64.tar.gz $CADDY_DL && \
        tar -zxf /tmp/caddy/caddy_linux_amd64.tar.gz -C /tmp/caddy && \
        mv /tmp/caddy/caddy /usr/bin/ && \
        chmod +x /usr/bin/caddy && \
	chmod +x /usr/local/bin/entrypoint.sh && \
        rm -rf /tmp/caddy && \
        apk del --purge $buildDeps
        
VOLUME  $CERT_DIR
VOLUME	$WEB_DIR
VOLUME	$WEB_DIR$FILE_PATH

EXPOSE  443

ENTRYPOINT	["entrypoint.sh"]
