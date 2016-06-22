package {'puppetdb-terminus': ensure => installed, }

node 'nagios' {
	include nagios3::server
}

node 'vagrant-ubuntu-trusty-64.toya.net.pl' {
	include apache
	class {'nagios3::client':	}
  include nagios3::checks::apache2
  nagios3::checks::port { 'webserver':  }
  nagios3::checks::script { 'apache_lines':
    check_warn => 60,
    check_crit => 40
    }
}
