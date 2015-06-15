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

# Install and configure dependencies

echo 'mysql-server mysql-server/root_password password vagrant' | debconf-set-selections;
echo 'mysql-server mysql-server/root_password_again password vagrant' | debconf-set-selections;
echo 'mysql-server-5.1 mysql-server/root_password password vagrant' | debconf-set-selections;
echo 'mysql-server-5.1 mysql-server/root_password_again password vagrant' | debconf-set-selections;
echo 'mysql-server-5.5 mysql-server/root_password password vagrant' | debconf-set-selections;
echo 'mysql-server-5.5 mysql-server/root_password_again password vagrant' | debconf-set-selections;

apt-install mysql-server;

apt-install wget apache2 php5 php5-cli php5-mysql libapache2-mod-php5;

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

# Create database and user
mysql -uroot -pvagrant -e "CREATE DATABASE IF NOT EXISTS wordpress;";
mysql -uroot -pvagrant -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'heCrE7*d2KEs';";
mysql -uroot -pvagrant -e "GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'localhost' WITH GRANT OPTION;";

touch /provisioned;
