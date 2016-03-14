#
class nagios3::server (
  $contact_group_name     = $nagios3::params::contact_group_name,
  $contact_group_members  = $nagios3::params::contact_group_members
  ) inherits nagios3::params {
  include 'nagios3::server::install'
  include 'nagios3::server::service'
  include 'nagios3::server::import'
  include 'nagios3::server::config'
  include 'nagios3::server::contactgroup'
  include 'nagios3::server::contacts'

  anchor { 'nagios3::server::start': }
  anchor { 'nagios3::server::end': }

  Anchor['nagios3::server::start'] ->
  Class['nagios3::server::install'] ->
  Class['nagios3::server::config'] ->
  Class['nagios3::server::service'] ->
  Anchor['nagios3::server::end']
}
