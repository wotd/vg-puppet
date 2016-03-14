# == Class: nagios3
#
# Full description of class nagios3 here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'nagios3':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class nagios3 (
  $nagios_server_ip       = $nagios3::params::nagios_server_ip,
  $contact_group          = $nagios3::params::contact_group,
  $checktime_period       = $nagios3::params::checktime_period,
  $contact_group_name     = $nagios3::params::contact_group_name,
  $contact_group_members  = $nagios3::params::contact_group_members,
  $apache_check           = $nagios3::params::apache_check,
  $apaches_check          = $nagios3::params::apaches_check,
  $apache_warn_min_procs  = $nagios3::params::apache_warn_min_procs,
  $apache_warn_max_procs  = $nagios3::params::apache_warn_max_procs,
  $apache_crit_min_procs  = $nagios3::params::apache_crit_min_procs,
  $apache_crit_max_procs  = $nagios3::params::apache_crit_max_procs,
  $mysql_check            = $nagios3::params::mysql_check,
  $postgresql_check       = $nagios3::params::postgresql_check,
  $ps_warn_min_procs      = $nagios3::params::ps_warn_min_procs,
  $ps_warn_max_procs      = $nagios3::params::ps_warn_max_procs,
  $ps_crit_min_procs      = $nagios3::params::ps_crit_min_procs,
  $ps_crit_max_procs      = $nagios3::params::ps_crit_max_procs,
  $rabbitmq_check         = $nagios3::params::rabbitmq_check,
  $varnish_check          = $nagios3::params::varnish_check,
  $smtp_check             = $nagios3::params::smtp_check
  ) inherits nagios3::params {

    include 'nagios3::client'
    include 'nagios3::checks'

    anchor { 'nagios3::start': }
    anchor { 'nagios3::end': }

    Anchor['nagios3::start'] ->
    Class['nagios3::client'] ->
    Class['nagios3::checks'] ->
    Anchor['nagios3::end']

}
