#!/bin/bash

wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update
apt-get -y install puppet
echo "192.168.50.2 puppet" >> /etc/hosts
echo "192.168.50.40 lamp" >> /etc/hosts
echo "192.168.50.4 nagios" >> /etc/hosts
#cp /vagrant/puppet_agent.conf /etc/puppet/puppet.conf
sed -i".bak" '/^templatedir=.*/d' /etc/puppet/puppet.conf
puppet agent --enable

