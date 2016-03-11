#
class nagios3::client ($nagios_server_ip = $nagios3::params::nagios_server_ip) inherits nagios3::params {
  include 'nagios3::client::install'
  include 'nagios3::client::config'
  include 'nagios3::client::service'
  #
  include 'nagios3::checks::default'
}
