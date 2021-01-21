#!/bin/sh

# install stable nginx
# even though nginx will be replaced
# by compiling from source
# this installs latest versions
# of required libs
add-apt-repository -y ppa:nginx/stable \
  && apt-get update \
  && apt-get install -y nginx \
  && chown -R www-data:www-data /var/lib/nginx \
  && mv /etc/nginx /etc/nginx.orig

# upgrade the rest of the stack
apt-get upgrade -y

# install dev libraries to compile nginx
# from source
apt-get install \
    libc6-dev \
    libgd-dev \
    libgeoip-dev \
    libpcre3-dev \
    libssl-dev \
    -y

# download location to build libs
mkdir -p /build && cd /build

# install luajit
wget -O luajit.tar.gz http://luajit.org/download/LuaJIT-2.0.3.tar.gz \
    && mkdir luajit \
    && tar -zxf luajit.tar.gz -C luajit --strip-components=1 \
    && cd luajit \
    && make PREFIX=/usr/local \
    && make install \
    && export LUAJIT_LIB=/usr/local/lib \
    && export LUAJIT_INC=`cd /usr/local/include/lua* && pwd` \
    && cd /build

# download nginx
wget -O nginx.tar.gz http://nginx.org/download/nginx-1.9.9.tar.gz \
    && mkdir nginx \
    && tar -zxf nginx.tar.gz -C nginx --strip-components=1

# download optional nginx modules to enable
wget -O nginx.dav.tar.gz https://github.com/arut/nginx-dav-ext-module/archive/master.tar.gz \
    && mkdir nginx-dav-ext-module \
    && tar -zxf nginx.dav.tar.gz -C nginx-dav-ext-module --strip-components=1
wget -O nginx.fair.tar.gz https://github.com/gnosek/nginx-upstream-fair/archive/master.tar.gz \
    && mkdir nginx-upstream-fair \
    && tar -zxf nginx.fair.tar.gz -C nginx-upstream-fair --strip-components=1
wget -O nginx.sub.tar.gz https://github.com/yaoweibin/ngx_http_substitutions_filter_module/archive/master.tar.gz \
    && mkdir ngx_http_substitutions_filter_module \
    && tar -zxf nginx.sub.tar.gz -C ngx_http_substitutions_filter_module --strip-components=1

# download lua nginx modules
wget -O nginx.dev.tar.gz https://github.com/simpl/ngx_devel_kit/archive/v0.2.19.tar.gz \
    && mkdir ngx_devel_kit \
    && tar -zxf nginx.dev.tar.gz -C ngx_devel_kit --strip-components=1
wget -O nginx.lua.tar.gz https://openresty.org/download/nginx-1.19.3.tar.gz \
    && mkdir lua-nginx-module \
    && tar -zxf nginx.lua.tar.gz -C lua-nginx-module --strip-components=1

cd /build/nginx

# configure nginx, build it and install nginx
./configure \
    --with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' \
    --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro' \
    --sbin-path=/usr/sbin/nginx \
    --prefix=/usr/share/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --lock-path=/var/lock/nginx.lock \
    --pid-path=/run/nginx.pid \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --with-debug \
    --with-pcre-jit \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_auth_request_module \
    --with-http_addition_module \
    --with-http_geoip_module \
    --with-http_gzip_static_module \
    --with-http_image_filter_module \
    --add-module=/build/ngx_http_substitutions_filter_module \
    --add-module=/build/ngx_devel_kit \
    --add-module=/build/lua-nginx-module/ \
    && make build \
    && make install

# cleanup
rm -rf /build && rm -rf /etc/nginx && mv /etc/nginx.orig /etc/nginxc




./configure \
    --with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 ' \
    --with-ld-opt='-Wl,-z,relro' \
    --sbin-path=/usr/sbin/nginx \
    --prefix=/usr/share/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --lock-path=/var/lock/nginx.lock \
    --pid-path=/run/nginx.pid \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --with-debug \
    --with-pcre-jit \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_auth_request_module \
    --with-http_addition_module \
    --with-http_geoip_module \
    --with-http_gzip_static_module \
    --with-http_image_filter_module \
    --add-module=/build/ngx_http_substitutions_filter_module \
    --add-module=/build/ngx_devel_kit \
    --add-module=/build/lua-nginx-module/ \
    && make build \
    && make install
