FROM ubuntu:14.04

ENV MYSQL_DATA_DIR /var/lib/mysql
# ENV MYSQL_RUN_DIR /run/mysqld
# ENV MYSQL_LOG_DIR /var/log/mysql
ENV TERM xterm
ENV MYSQL_USER admin
ENV MYSQL_PASSWORD milk432
	
RUN apt-get update
RUN apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server apache2 bash-completion vim git supervisor ghostscript memcached curl mysql-server mysql-client \
	php5 php5-cli libapache2-mod-php5 php5-gd php5-json php5-ldap php5-mysql php5-mcrypt php5-memcached php5-curl

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

# ADD apache_default /etc/apache2/sites-available/000-default.conf
# ADD apache_opt.conf /etc/apache2/conf-enabled/optimise.conf
COPY configs/apache_default /etc/apache2/sites-available/000-default.conf
# COPY configs/tpv.conf /etc/apache2/sites-available/tpv.conf
COPY configs/xdebug.ini /etc/php5/mods-available/xdebug.ini

# COPY configs/default_index.html /var/www/html/index.html
# COPY configs/logo.png /var/www/html/logo.png

RUN a2enmod rewrite
# RUN a2ensite tpv

# add supervisord configuration file 
COPY configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# add mysql start script
COPY scripts/mysql.sh /opt/mysql.sh

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN export TERM=xterm

EXPOSE 80 443 3306 9000 11211

VOLUME ["/var/www", "${MYSQL_DATA_DIR}"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]