#
class nagios3::server::import {
  Nagios_host <<||>> {
    require => Class['nagios3::server::install'],
    notify  => Class['nagios3::server::service'],
  }

  Nagios_service <<||>> {
    require => Class['nagios3::server::install'],
    notify  => Class['nagios3::server::service'],
  }
}
