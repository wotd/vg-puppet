#
class nagios3::client::install {
  $packages = [
  'nagios-nrpe-server',
  'nagios-plugins',
  'nagios-plugins-standard'
  ]
  package {$packages:
    ensure => 'installed',
    }
}
