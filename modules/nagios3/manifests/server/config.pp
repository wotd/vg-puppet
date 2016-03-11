#
class nagios3::server::config {
  file_line { 'check_external_commands':
    ensure  => 'present',
    line    => 'check_external_commands=1',
    path    => '/etc/nagios3/nagios.cfg',
    match   => 'check_external_commands',
    require =>  Class['nagios3::server::install'],
    notify  =>  Service['nagios3'],
  }
}
