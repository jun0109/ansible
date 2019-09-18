FROM centos:7

RUN yum update -y && \
    yum install -y epel-release
RUN yum install yum-utils
RUN touch /etc/yum.repos.d/nginx.repo
COPY ./nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./phpinfo.php /var/www/html/phpinfo.php
RUN yum clean all

CMD nginx
