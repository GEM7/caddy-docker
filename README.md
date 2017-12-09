# caddyhttp2proxy
A simple easy-to-use caddy http2 proxy and filemanager!

# How to use

- You must get TLS certs files in advance and rename them as the listed format, if your domain name is mydomain.com, they will be like listed below.
```
mydomain.com.crt
mydomain.com.key
```
and put them to the same place.

- To be proxy alone, do:

```
docker -d -e DOMAIN="YourDomain" -v Path_to_certs:/srv/docker/certs -p 443:443 rpmdpkg/caddyhttp2proxy
```
The basic auth user and password for proxy will be `HTTP2proxy` and `http2PROXY` by dedault. If you want to change them, just append a command `-e PROXY_USER="username" -e PROXY_PASS="password"` to the command listed below before  "rpmdpkg/caddyhttp2proxy"

- To be filemanager, do:

```
docker -d -e DOMAIN="YourDomain" -e PROXY_USER="user" -e PROXY_PASS="pass" -v Path_to_share:/srv/docker/caddy/share -v Path_to_certs:/srv/docker/certs -p 443:443 rpmdpkg/caddyhttp2proxy
```

The filemanager user will be `Admin` and the password will be `Administrator` by default if not specified by adding `-e PROXY_USER="user" -e PROXY_PASS="pass"` parameter.
