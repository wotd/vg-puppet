#!/bin/bash

wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update
locale-gen pl_PL pl_PL.UTF-8
dpkg-reconfigure locales
apt-get -y install puppetmaster postgresql-contrib puppetdb-terminus
echo "192.168.50.40 lamp" >> /etc/hosts
echo "192.168.50.4 db" >> /etc/hosts
echo "192.168.50.2 puppet" >> /etc/hosts
cp -avr /etc/puppet/environments/example_env/ /etc/puppet/environments/production
echo "Prepare puppet.conf"
sed -i".bak" '/^templatedir=.*/d' /etc/puppet/puppet.conf
echo "" >>/etc/puppet/puppet.conf
echo "storeconfigs = true" >> /etc/puppet/puppet.conf
echo "storeconfigs_backend = puppetdb" >> /etc/puppet/puppet.conf
echo "reports = store,puppetdb" >> /etc/puppet/puppet.conf
echo "Done!"
echo "Changing modules location..."
rm -rf /etc/puppet/modules
rm -rf /etc/puppet/manifests
ln -s /vagrant/modules /etc/puppet/
ln -s /vagrant/manifests /etc/puppet/
echo "Installing modules..."
echo "[*] Apache2: "
puppet module install puppetlabs-apache
echo "[*] MySQL: "
puppet module install puppetlabs-mysql
echo "[*] stdlib: "
puppet module install puppetlabs-stdlib
echo "PuppetDB installation"
puppet resource package puppetdb ensure=latest
echo "Postresql config"
cp /vagrant/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
echo "PuppetDB config 1/4 ..."
cp /vagrant/puppetdb /etc/default/puppetdb
echo "PuppetDB config 2/4 ..."
cp /vagrant/routes.yaml /etc/puppet/routes.yaml
echo "PuppetDB config 3/4 ..."
cp /vagrant/puppetdb.conf /etc/puppet/puppetdb.conf
echo "PuppetDB config 4/4 ..."
cp /vagrant/database.ini /etc/puppetdb/conf.d
chown -R puppet:puppet `sudo puppet config print confdir`
echo "package {'puppetdb-terminus': ensure => installed, }" > /etc/puppet/manifests/site.pp
echo "Setup Postresql database for puppetdb..."
/etc/init.d/puppetdb restart
/etc/init.d/puppetmaster restart
/etc/init.d/postgresql restart
sudo -u postgres psql -c "create user \"puppetdb\" with password 'getstarted';"
sudo -u postgres psql -c "create database \"puppetdb\" with owner \"puppetdb\";"
sudo -u postgres psql puppetdb -c 'create extension pg_trgm'
/etc/init.d/puppetdb stop
/etc/init.d/puppetmaster stop
/etc/init.d/postgresql stop
/etc/init.d/puppetdb start
/etc/init.d/puppetmaster start
/etc/init.d/postgresql start
