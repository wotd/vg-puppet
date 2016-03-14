package {'puppetdb-terminus': ensure => installed, }


case $operatingsystem {
	'CentOS': {
		$packages = [
		'wget',
		]
	}
	'Ubuntu': {
		$packages = [
		'htop',
		]
	}
}

node 'nagios' {
	class { 'nagios3::server':		}
}

node 'ubuntu' {
	include apache
  include mysql::server
	#include nagios3
	class { 'nagios3': }

  nagios3::checks::port { 'port80':
    port  => 80,
    }



      include nagios3::checks::postgresql
      include nagios3::checks::rabbitmq
      include nagios3::checks::smtp
      include nagios3::checks::cassandra

	#include 'nagios3::client'
	class { 'nagios3::checks::apache2':
		apache_check	=> 'present',
		apaches_check	=> 'present',
		}
  class { 'nagios3::checks::mysql':
        mysql_check   => 'present',
  }
}
package { "$packages":
	ensure => installed,
}
