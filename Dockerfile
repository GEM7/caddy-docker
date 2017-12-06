FROM    alpine:latest

ENV     DOMAIN  YOUR_DOMAIN
ENV     EMAIL   YOUR_EMAIL_ADDRESS
ENV     CERT_DIR /etc/certs

RUN     buildDeps="curl unzip" && \
        set -x &&\
        mkdir -p /tmp/caddy && \
        mkdir -p $CERT_DIR && \
        apk add --no-cache curl unzip && \
        curl -sl -o /tmp/caddy/caddy_linux_amd64.tar.gz "https://caddyserver.com/download/linux/amd64?plugins=http.forwardproxy&license=personal" && \
        tar -zxf /tmp/caddy/caddy_linux_amd64.tar.gz -C /tmp/caddy && \
        mv /tmp/caddy/caddy /usr/bin/ && \
        chmod +x /usr/bin/caddy && \
        rm -rf /tmp/caddy && \
        apk del --purge $buildDeps
   #     echo "http://${DOMAIN}:443 {" > /etc/Caddyfile && \
  #      echo "gzip" >> /etc/Caddyfile && \
 #       echo "tls $EMAIL" >> /etc/Caddyfile && \
 #       echo "log /dev/stderr" >> /etc/Caddyfile  && \
#        echo "forwardproxy" >> /etc/Caddyfile && \ 
#        echo "}" >> /etc/Caddyfile
        
VOLUME  /etc/certs
VOLUME  /root/.caddy

ADD     CaddyFile       /etc/Caddyfile

EXPOSE  443

ENTRYPOINT      ["/usr/bin/caddy"]
CMD     ["--conf", "/etc/Caddyfile"]
