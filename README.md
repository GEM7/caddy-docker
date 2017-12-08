# caddyhttp2proxy
A simple easy-to-use caddy http2 proxy

# How to use

```
docker -d -e DOMAIN="YourDomain" -v Path_to_certs:/srv/docker/certs -p 443:443 rpmdpkg/caddyhttp2proxy
```
