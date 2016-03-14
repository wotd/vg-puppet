#
class nagios3::client::config ($nagios_server_ip = $nagios3::nagios_server_ip) inherits nagios3 {
 file_line { 'allowed_hosts':
  ensure  => 'present',
  line    => "allowed_hosts=127.0.0.1,$nagios_server_ip",
  path    => '/etc/nagios/nrpe.cfg',
  match   => 'allowed_hosts',
  require => Class['nagios3::client::install'],
  notify  => Service['nagios-nrpe-server'],
 }

file_line { 'nagios_sudo':
  line    => 'nagios  ALL=(root) NOPASSWD: /usr/lib/nagios/plugins/check_puppet.rb',
  path    => '/etc/sudoers',
  ensure  => 'present',
}

}
