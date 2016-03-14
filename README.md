# vg-puppet
Vagrant files for installation and configuration puppet lab

Usage: put files in directory and just use vagrant up command :)


It contains 4 servers:
 - ubuntu - that can be used to test puppet modules
 - puppet - puppet / puppetdb server.
 - nagios - used for nagios3 module testing. can be used with any other modules also
 - centos - can be used for testing with $operatingsystem facter or with developing universal modules (OS independed) 
