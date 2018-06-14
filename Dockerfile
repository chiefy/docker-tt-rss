FROM alpine:3.7

RUN apk add --no-cache \
  curl \
  php7 \
  php7-curl \
  php7-xml \
  php7-xmlreader \
  php7-fpm \
  php7-fileinfo \
  php7-json \
  php7-pdo \
  php7-pdo_pgsql \
  php7-pgsql \
  php7-openssl \
  php7-opcache \
  php7-common \
  php7-phar \
  php7-mbstring \
  php7-session \
  php7-gd \
  php7-posix \
  php7-zlib \
  # Tweak configs
  && sed -i \
  -e "s,expose_php = On,expose_php = Off,g" \
  -e "s,;cgi.fix_pathinfo=1,cgi.fix_pathinfo=0,g" \
  -e "s,post_max_size = 8M,post_max_size = 100M,g" \
  -e "s,upload_max_filesize = 2M,upload_max_filesize = 100M,g" \
  /etc/php7/php.ini \
  && sed -i \
  -e "s,;daemonize = yes,daemonize = no,g" \
  -e "s,user = nobody,user = www,g" \
  -e "s,;chdir = /var/www,chdir = /var/www/tt-rss,g" \
  -e "s,listen = 127.0.0.1:9000,listen = 0.0.0.0:9000,g" \
  -e "s,;clear_env = no,clear_env = no,g" \
  /etc/php7/php-fpm.d/www.conf \
  # forward logs to docker log collector
  && ln -sf /dev/stderr /var/log/php7/error.log \
  && mkdir -p /var/www/tt-rss \
  && curl -SsL https://git.tt-rss.org/fox/tt-rss/archive/master.tar.gz | tar xvz --strip-components 1 -C /var/www/tt-rss \
  && adduser -S -D -H www \
  && chmod -R +x /var/www/tt-rss/*.php \
  && chown -R www /var/www/tt-rss

USER www

WORKDIR /var/www/tt-rss

COPY scripts/* ./

EXPOSE 9000

CMD ./start.sh
