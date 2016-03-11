#
class nagios3::client::service {
  service { 'nagios-nrpe-server':
    ensure => running,
    enable => true,
    require => Package[nagios-nrpe-server],
    }
}
