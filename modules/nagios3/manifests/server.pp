#
class nagios3::server {
  include 'nagios3::server::install'
  include 'nagios3::server::service'
  include 'nagios3::server::import'
  include 'nagios3::server::config'

  anchor { 'nagios3::server::start': }
  anchor { 'nagios3::server::end': }

  Anchor['nagios3::server::start'] ->
  Class['nagios3::server::install'] ->
  Class['nagios3::server::config'] ->
  Class['nagios3::server::service'] ->
  Anchor['nagios3::server::end']
}
