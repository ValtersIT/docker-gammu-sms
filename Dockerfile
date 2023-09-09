FROM ubuntu:latest
ENV MAINTAINER https://www.valters.eu
ENV maintainer="outsourcing@valters.eu"

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

ENV TZ=Europe/Riga
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y gammu gammu-smsd

RUN apt-get -y update && apt-get -y upgrade && apt-get install -y \
     apache2 \
     apache2-utils \
     && \
     rm -rf /var/cache/apt/*

RUN a2enmod rewrite
RUN a2enmod ssl

RUN apt-get update && apt-get upgrade && apt-get install -y \
     php7.4 \
     php7.4-cli \
     php7.4-phar \
     php7.4-zip \ 
     php7.4-bz2 \
     php7.4-ctype \
     php7.4-curl \
     php7.4-mysqli \
     php7.4-json \
     php7.4-xml \
     php7.4-dom \
     php7.4-iconv \
     php7.4-exif \
     php7.4-xdebug \
     php7.4-intl \
     php7.4-gd \
     php7.4-mbstring \
     php7.4-apcu \
     php7.4-opcache \
     php7.4-tokenizer \
     php7.4-simplexml \
     php7.4-soap \
     php7.4-gmp \
     php7.4-bcmath \
     php7.4-fileinfo \
     php7.4-imap \
     && \
     rm -rf /var/cache/apt/*

RUN apt-get update && apt-get upgrade && apt-get install -y \
     nano \
     curl \
     tzdata \
     zip \
     cron \
     && \
     rm -rf /var/cache/apt/*

RUN groupadd -g 2000 valterg 
RUN useradd -s /sbin/nologin valterseu
RUN usermod -a -G valterg valterseu

RUN mkdir -p /var/log/gammu /var/spool/gammu/{inbox,outbox,sent,error}
RUN chown -R valterseu:valterg /var/spool/gammu/*
RUN chmod 777 -R /var/spool/gammu/*
RUN rm -rf /var/www/html/index.html

ADD gammu-smsdrc /etc/
ADD index.php /var/www/html/

EXPOSE 80 443
CMD ( /etc/init.d/gammu-smsd start && tail -f /var/log/gammu & ) && apachectl -D FOREGROUND