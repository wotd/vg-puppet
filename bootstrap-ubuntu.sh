#!/bin/bash
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
locale-gen pl_PL pl_PL.UTF-8
dpkg-reconfigure locales
apt-get update
apt-get -y install puppet
echo "192.168.50.2 puppet" >> /etc/hosts
echo "192.168.50.40 lamp" >> /etc/hosts
echo "192.168.50.4 db" >> /etc/hosts
sed -i".bak" '/^templatedir=.*/d' /etc/puppet/puppet.conf
puppet agent --enable
