#class is used to install nagios3 server
class nagios3::server::install {
  $packages = [
  'nagios3',
  'nagios-plugins',
  'nagios-nrpe-plugin'
  ]
  package { $packages:
    ensure => 'installed',
    }
}
