#
class nagios3::client::config ($nagios_server_ip = $nagios3::client::nagios_server_ip) inherits nagios3::client {
 file_line { 'allowed_hosts':
  ensure  => 'present',
  line    => "allowed_hosts=127.0.0.1,$nagios_server_ip",
  path    => '/etc/nagios/nrpe.cfg',
  match   => 'allowed_hosts',
  require => Package['nagios-nrpe-server'],
  notify  => Service['nagios-nrpe-server'],
 }
}
