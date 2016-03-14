#
class nagios3::checks::apache2 (
  $apache_check           = $nagios3::apache_check,
  $apaches_check          = $nagios3::apaches_check,
  $contact_group          = $nagios3::contact_group,
  $apache_warn_min_procs  = $nagios3::apache_warn_min_procs,
  $apache_warn_max_procs  = $nagios3::apache_warn_max_procs,
  $apache_crit_min_procs  = $nagios3::apache_crit_min_procs,
  $apache_crit_max_procs  = $nagios3::apache_crit_max_procs
) inherits nagios3 {

  @@nagios_service { "check_http_${hostname}":
    ensure              => "$apache_check",
    contact_groups      => "$contact_group",
    check_command       => 'check_http!',
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    service_description => "${hostname}_check_http",
    max_check_attempts  => '10',
    target              => '/etc/nagios3/conf.d/autonagios_service.cfg',
   }

   file_line { 'check_procs_web':
    ensure  => "$apache_check",
    line    => "command[check_procs_web]=/usr/lib/nagios/plugins/check_procs -w $apache_warn_min_procs:$apache_warn_max_procs -c $apache_crit_min_procs:$apache_crit_max_procs -C apache2",
    path    => '/etc/nagios/nrpe_local.cfg',
    notify  => Service['nagios-nrpe-server'],
    match   => '^command\[check_procs_web\]=\/usr\/lib\/nagios\/plugins\/check_procs -w \d*:\d* -c \d*:\d* -C apache2',
  }

  @@nagios_service { "check_httpd_${hostname}":
    ensure              => "$apache_check",
    contact_groups      => "$contact_group",
    check_command       => "check_nrpe_1arg!check_procs_web",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_httpd",
    max_check_attempts  => '10',
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
  }

  @@nagios_service { "check_https_${hostname}":
     ensure              => "$apaches_check",
     contact_groups      => "$contact_group",
     check_command       => "check_tcp!443",
     use                 => "generic-service",
     host_name           => "$fqdn",
     notification_period => "24x7",
     check_period        => '24x7',
     service_description => "${hostname}_https",
     max_check_attempts  => '10',
     target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
  Class['nagios3::client::install'] -> Class['nagios3::checks::apache2']
}
