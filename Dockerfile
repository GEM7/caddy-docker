FROM    alpine:latest

MAINTAINER	Adam	github.com/GEM7

ENV     CADDY_DL="https://caddyserver.com/download/linux/amd64?plugins=http.filemanager,http.forwardproxy&license=personal" \
	DOMAIN="" \
	CERT_DIR=/srv/docker/certs \
	WEB_DIR=/srv/docker/caddy \
	FILE_PATH=/share \
	FILE_USER=Admin \
	FILE_PASS=Administrator \
	PROXY_USER=HTTP2proxy \
	PROXY_PASS=http2PROXY
		

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
        rm -rf /tmp/caddy && \
        apk del --purge $buildDeps
        
VOLUME  $CERT_DIR
VOLUME	$WEB_DIR
VOLUME	$WEB_DIR$FILE_PATH

ADD	CaddyFile	/etc/CaddyFile
ADD	index.html	$WEB_DIR/index.html

EXPOSE  443

ENTRYPOINT	sed -i "s|DOMAIN|$DOMAIN|g"			/etc/CaddyFile	&&\
		sed -i "s|FILE_PATH|$FILE_PATH|g"		/etc/CaddyFile	&&\
		sed -i "s|WEB_DIR|$WEB_DIR|g"			/etc/CaddyFile	&&\
		sed -i "s|CERT_DIR|$CERT_DIR|g"			/etc/CaddyFile	&&\
		sed -i "s|FILE_USER|$AUTH_USER|g"		/etc/CaddyFile	&&\
		sed -i "s|FILE_PASS|$AUTH_PASS|g"		/etc/CaddyFile	&&\
		sed -i "s|PROXY_USER|$PROXY_USER|g"		/etc/CaddyFile	&&\
		sed -i "s|PROXY_PASS|$PROXY_PASS|g"		/etc/CaddyFile	&&\
		/usr/bin/caddy -conf /etc/CaddyFile
#CMD     ["-conf", "/etc/CaddyFile"]
