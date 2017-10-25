#!/usr/bin/env bash
#
# set -x;
set -e;
set -o pipefail;
#
thisFile="$(readlink -f ${0})";
thisFilePath="$(dirname ${thisFile})";

# Only provision once
if [ -f /provisioned ]; then
  exit 0;
fi

export DEBIAN_FRONTEND=noninteractive;

shopt -s expand_aliases;
alias apt-update='apt-get update -qq';
alias apt-install='apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"';

apt-update;
apt-install debconf-utils;

echo 'mysql-server mysql-server/root_password password vagrant' | debconf-set-selections;
echo 'mysql-server mysql-server/root_password_again password vagrant' | debconf-set-selections;
echo 'mysql-server-5.1 mysql-server/root_password password vagrant' | debconf-set-selections;
echo 'mysql-server-5.1 mysql-server/root_password_again password vagrant' | debconf-set-selections;
echo 'mysql-server-5.5 mysql-server/root_password password vagrant' | debconf-set-selections;
echo 'mysql-server-5.5 mysql-server/root_password_again password vagrant' | debconf-set-selections;
echo 'mysql-server-5.6 mysql-server/root_password password vagrant' | debconf-set-selections;
echo 'mysql-server-5.6 mysql-server/root_password_again password vagrant' | debconf-set-selections;

apt-install mysql-server;

cat << EOF > ~/.my.cnf
[client]
host = 127.0.0.1
user = root
password = vagrant
EOF

# No .my.cnf needed for Debian 9 (MariaDB)
if $(lsb_release -c | grep -qE '(stretch)'); then
  rm ~/.my.cnf;
fi

# No PHP 5 support in Ubuntu 16.04 and Debian 9
if $(lsb_release -c | grep -qE '(xenial|stretch)'); then
  PHP_VERSION='7.0';
else
  PHP_VERSION='5';
fi
apt-install wget apache2 "php${PHP_VERSION}" "php${PHP_VERSION}-cli" "php${PHP_VERSION}-mysql" "libapache2-mod-php${PHP_VERSION}";

# Remove default index page of Ubuntu 1(0|2).04 / Debian (6|7)
if [ -f /var/www/index.html ]; then
  rm -f /var/www/index.html;
fi
# Fix default document root of Ubuntu 14.04
if [ -f /etc/apache2/sites-available/000-default.conf ]; then
  sed -i 's|/var/www/html|/var/www|g' /etc/apache2/sites-available/000-default.conf;
fi

a2enmod rewrite;
service apache2 reload;

# Fix missing sendmail
ln -s -f /bin/true /usr/sbin/sendmail;

mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;";
mysql -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'heCrE7*d2KEs';";
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'localhost' WITH GRANT OPTION;";

touch /provisioned;
