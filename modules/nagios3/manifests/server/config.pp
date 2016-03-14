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

#Set nagiosadmin password to "2" - it is only for testing purpose and should be changed by executing command: htpasswd /etc/nagios3/htpasswd.users nagiosadmin
  file { '/etc/nagios3/htpasswd.users':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '664',
    content => 'nagiosadmin:$apr1$SvKSmmfk$0eSwvBlxJKqWLWICKcVNq1',
    }
}
