#
class nagios3::client::service {
  service { 'nagios-nrpe-server':
    ensure => running,
    enable => true,
    require => Class['nagios3::client::config'],
    }
}
