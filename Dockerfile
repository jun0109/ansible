FROM centos:7

ENV TZ "Asia/Taipei"

RUN mkdir -p /usr/local/nginx/html

RUN yum update -y && \
    yum install -y epel-release
RUN yum install -y yum-utils gcc automake autoconf libtool make gcc-c++ vixie-cron  wget zlib  file openssl-devel sharutils zip  bash vim cyrus-sasl-devel libmemcached libmemcached-devel libyaml libyaml-devel unzip libvpx-devel openssl-devel ImageMagick-devel  autoconf  tar gcc libxml2-devel gd-devel libmcrypt-devel libmcrypt mcrypt mhash libmcrypt libmcrypt-devel libxml2 libxml2-devel bzip2 bzip2-devel curl curl-devel libjpeg libjpeg-devel libpng libpng-devel freetype-devel bison libtool-ltdl-devel net-tools libmcrypt-devel 

COPY ./roles/harbor/files/phpinfo.php /usr/local/nginx/html/phpinfo.php
COPY ./roles/harbor/files/phpredis /home/phpredis

RUN yum clean all

RUN cd /tmp && \
  wget http://nginx.org/download/nginx-1.11.5.tar.gz && \
  tar xzf nginx-1.11.5.tar.gz && \
  cd /tmp/nginx-1.11.5 && \
  ./configure \
    --prefix=/usr/local/nginx \
    --with-http_ssl_module --with-http_sub_module --with-http_dav_module --with-http_flv_module \
    --with-http_gzip_static_module --with-http_stub_status_module --with-debug && \
    make && \
    make install

ENV HTTP_PHP_CONFIG \\\n\\\t#php\\\n\\\tlocation ~ \\\\.php$ {\\\n\\\t\\\troot    html;\\\n\\\t\\\tfastcgi_pass   127.0.0.1:9000;\\\n\\\t\\\tfastcgi_index    index.php;\\\n\\\t\\\tfastcgi_param  SCRIPT_FILENAME    /usr/local/nginx/html\$fastcgi_script_name;\\\n\\\t\\\tinclude    fastcgi_params;\\\n\\\t}\\\n\\\n\\\t

RUN sed -i -e "s@# deny access to .htaccess files, if Apache@${HTTP_PHP_CONFIG}# deny access to .htaccess files, if Apache@" /usr/local/nginx/conf/nginx.conf


RUN cd /tmp && \
  wget http://cn2.php.net/distributions/php-7.0.12.tar.gz && \
  tar xzf php-7.0.12.tar.gz && \
  cd /tmp/php-7.0.12 && \
  ./configure \
    --prefix=/usr/local/php \
    --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir --enable-simplexml --enable-xml --disable-rpath --enable-bcmath --enable-soap --enable-zip --with-curl --enable-fpm --with-fpm-user=nobody --with-fpm-group=nobody --enable-mbstring --enable-sockets --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-opcache && \
    make && \
    make install

RUN cp /tmp/php-7.0.12/php.ini-production /usr/local/php/lib/php.ini && \
    cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
    cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf


RUN sed -i -e 's/listen = 127.0.0.1:9000/listen = 9000/' /usr/local/php/etc/php-fpm.d/www.conf

RUN yum install python-setuptools -y
RUN easy_install supervisor
COPY ./roles/harbor/files/supervisord.conf /etc/supervisord.conf
RUN supervisord -v

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/supervisord", "-c","etc/supervisord.conf"]