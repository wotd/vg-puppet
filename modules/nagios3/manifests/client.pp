#
class nagios3::client {
  include 'nagios3::client::install'
  include 'nagios3::client::config'
  include 'nagios3::client::service'
  #
  anchor { 'nagios3::client::start': }
  anchor { 'nagios3::client::end': }

  Anchor['nagios3::client::start'] ->
  Class['nagios3::client::install'] ->
  Class['nagios3::client::config'] ->
  Class['nagios3::client::service'] ->
  Anchor['nagios3::client::end']
}
