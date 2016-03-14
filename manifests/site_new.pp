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
	include nagios3::server
}

node 'ubuntu' {
	include apache
	class {'nagios3::client':	}
}
package { "$packages":
	ensure => installed,
}
