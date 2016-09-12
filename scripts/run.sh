#!/bin/bash
set -e

# if [[ ! -d $MYSQL_DATA_DIR ]]; then
# 	mkdir $MYSQL_DATA_DIR && chmod 777 $MYSQL_DATA_DIR
# fi

# if [[ ! -d $LOG_HOME ]]; then
#	mkdir $LOG_HOME && chmod 777 $LOG_HOME
#	mkdir $LOG_HOME/apache2 && chmod 777 $LOG_HOME/apache2
# fi

# sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
#     -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
	
# PASS=${MYSQL_PASS:-$(pwgen -s 12 1)}

# /usr/sbin/mysqld &
# sleep 10
# echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '$PASS' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

exec supervisord -n

# /usr/bin/mysqld_safe --datadir=$MYSQL_DATA_DIR > /dev/null 2>&1 &

mysql -uroot -p$PASS --database mysql < /tmp/repair.sql
