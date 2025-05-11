#!/usr/bin/env bash

apt-get -y update

# Install Ruby on Rails

# Install some Ruby dependencies
echo "Installing some Ruby dependencies"
apt-get -y install git-core zlib1g-dev build-essential gcc libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Install Ruby (v3.2.2) from source
echo "Installing Ruby (v3.2.2)"
cd /tmp
wget http://ftp.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz
tar -xzvf ruby-3.2.2.tar.gz
cd ruby-3.2.2/
./configure
make
make install
ruby -v

# Now we tell Rubygems not to install the documentation for each package locally and then install Bundler
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler -v 2.4.22

# Install Rails (v7.1.2)
echo "Installing Rails (v7.1.2)"
gem install rails -v 7.1.2
rails -v

# Install PostgreSQL
echo "Installing PostgreSQL"
# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=10
apt -y update
apt -y install curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |tee  /etc/apt/sources.list.d/pgdg.list
apt -y update
apt -y install "postgresql-$PG_VERSION" "postgresql-client-$PG_VERSION" libpq-dev

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
sudo sed -i "$ a\host    all             all             all                     trust" "$PG_HBA"

# Restart so that all new config is loaded:
service postgresql restart
systemctl enable postgresql

# Create a PostgreSQL user for vagrant
sudo -u postgres createuser vagrant -s

exit
