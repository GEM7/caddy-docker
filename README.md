# caddyhttp2proxy
A simple easy-to-use caddy http2 proxy and filemanager!

# How to use

- To be proxy alone, do:

```
docker -d -e DOMAIN="YourDomain" -v Path_to_certs:/srv/docker/certs -p 443:443 rpmdpkg/caddyhttp2proxy
```
- To be filemanager, do:

```
docker -d -e DOMAIN="YourDomain" -e AUTH_USER="user" -e AUTH_PASS="pass" -v Path_to_share:/srv/docker/caddy/share -v Path_to_certs:/srv/docker/certs -p 443:443 rpmdpkg/caddyhttp2proxy
```
