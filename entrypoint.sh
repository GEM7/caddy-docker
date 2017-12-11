#!/bin/sh -x

sed -i "s|DOMAIN|$DOMAIN|g"			/etc/CaddyFile	&&\
sed -i "s|FILE_PATH|$FILE_PATH|g"		/etc/CaddyFile	&&\
sed -i "s|WEB_DIR|$WEB_DIR|g"			/etc/CaddyFile	&&\
sed -i "s|CERT_DIR|$CERT_DIR|g"			/etc/CaddyFile	&&\
sed -i "s|FILE_USER|$FILE_USER|g"		/etc/CaddyFile	&&\
sed -i "s|FILE_PASS|$FILE_PASS|g"		/etc/CaddyFile	&&\
sed -i "s|PROXY_USER|$PROXY_USER|g"		/etc/CaddyFile	&&\
sed -i "s|PROXY_PASS|$PROXY_PASS|g"		/etc/CaddyFile	&&\
/usr/bin/caddy -conf /etc/CaddyFile
