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

    file { '/usr/lib/nagios/plugins/check_puppet.rb':
      ensure  => 'present',
      source  => 'puppet:///modules/nagios3/check_puppet.rb',
      mode    => '755',
      require => Package['nagios-plugins-standard']
  }
}
