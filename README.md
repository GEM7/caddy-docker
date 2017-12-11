# caddy website & http2proxy & filemanager 3in1 docker
A simple easy-to-use caddy http2 proxy and filemanager!

# How to use

- You must get TLS certs files in advance and rename them as the listed format, if your domain name is mydomain.com, they will be like listed below. You can use certbot docker for instance.

```
mydomain.com.crt
mydomain.com.key
```
and put them to the same place.

# To be proxy alone:

do

```
docker -d -e DOMAIN="YourDomain"  \
  -v Path_to_certs:/srv/docker/certs \
  -e PROXY_USER="user" \
  -e PROXY_PASS="pass" \
  -p 443:443 \
  rpmdpkg/caddy-docker
```

  + Bind your domain, do `-e DOMAIN="YourDomain"`
  + Bind the certs to docker, do `Path_to_certs:/srv/docker/certs`
  + The basic auth user and password for proxy will be `HTTP2proxy` and `http2PROXY` by dedault. If you want to change them, just append a command `-e PROXY_USER="username" -e PROXY_PASS="password"` to the command listed below before  "rpmdpkg/caddy-docker"

# To be filemanager alone:

do

```
docker -d -e DOMAIN="YourDomain" \
-e FILE_PATH=/share \ 
-e FILE_USER="user" \
-e FILE_PASS="pass" \
-v Path_to_share:/srv/docker/caddy/share \
-v Path_to_certs:/srv/docker/certs \
-p 80:80 -p 443:443 \
rpmdpkg/caddy-docker
```

  + Bind your domain, do `-e DOMAIN="YourDomain"`
  + Bind the certs to docker, do `Path_to_certs:/srv/docker/certs`
  + The filemanager user will be `Admin` and the password will be `Administrator` by default.
  + The default path of filemanager will be `/share` if not set, you can set it by `-e FILE_PATH=/YourPath` and your address will be `yourdomain.com/Yourpath`
  + To link the path to be share on you server to `/srv/docker/caddy/share`, do `-v Path_to_share:/srv/docker/caddy/share`

- To host hour own website, add `-v pathtoyourwebdir:/srv/docker/caddy` and be sure to change the FILE_PATH to anything but "/" in advance.

# To host static website

- You can conbine those scripts together to use all of them at the same time, do:

```
docker -d -e DOMAIN="YourDomain"  \
  -v Path_to_certs:/srv/docker/certs \
  -e PROXY_USER="user" \
  -e PROXY_PASS="pass" \
  -e FILE_PATH=/share \ 
  -e FILE_USER="user" \
  -e FILE_PASS="pass" \
  -v Your_web_dir:/srv/docker/caddy \
  -v Path_to_share:/srv/docker/caddy/share \
  -p 80:80 -p 443:443 \
  rpmdpkg/caddy-docker
```
