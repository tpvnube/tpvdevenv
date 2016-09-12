tpvdevenv
===================================

A Docker image based on Ubuntu, serving PHP running as Apache Module. Useful for TPV developers in need for a fixed PHP version.

Tags
-----

* 5.5.9: Ubuntu 14.04 (LTS), Apache 2.4, PHP 5.5.9

Usage
------

```
docker run -d -P tpvnube/tpvdevenv
```

A bit more specific:

```
docker run -d -p 8080:80 -v /home/user/webroot:/var/www -e SERVER_PASSWORD=ubuntu tpvnube/tpvdevenv:5.5.9
```

* `-v [local path]:/var/www` maps the container's webroot to a local path
* `-p [local port]:80` maps a local port to the container's HTTP port 80

Installed packages
-------------------
* Ubuntu Server, based on ubuntu docker iamge
* openssh-server
* apache2
* bash-completion
* vim
* git
* ghostscript
* memcached
* curl
* php5
* php5-cli
* libapache2-mod-php5
* php5-gd
* php5-json
* php5-ldap
* php5-mysql
* php5-pgsql
* php5-mcrypt
* php5-curl

Configurations
----------------

* Apache: .htaccess-Enabled in webroot (mod_rewrite with AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL & ~E_DEPRECATED & ~E_NOTICE
