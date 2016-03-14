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
	#include nagios3
	class { 'nagios3':
		}

	#include 'nagios3::client'
	class { 'nagios3::checks::apache2':
		http_ensure	=> 'absent',
		https_ensure	=> 'absent',
		}
}
package { "$packages":
	ensure => installed,
}
