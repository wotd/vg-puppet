#!/bin/bash
yum -y install wget
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y install puppet
echo "192.168.50.2 puppet" >> /etc/hosts
echo "192.168.50.40 ubuntu" >> /etc/hosts
echo "192.168.50.50 nagios" >> /etc/hosts
echo "192.168.50.4 db" >> /etc/hosts
sed -i".bak" '/^templatedir=.*/d' /etc/puppet/puppet.conf
