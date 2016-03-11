#
class nagios3::server::service {
  exec { 'fix-permissions':
    command     => "find /etc/nagios3/conf.d -type f -name '*cfg' | xargs chmod +r",
    path        => ['/usr/bin', '/bin'],
    refreshonly => true,
  } ->
  service {'nagios3':
    ensure  => running,
    enable  => 'true',
    require => Class['nagios3::server::install'],
    }
}
