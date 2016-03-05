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



package { "$packages":
	ensure => installed,
}
