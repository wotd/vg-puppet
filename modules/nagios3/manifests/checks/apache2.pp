#
class nagios3::checks::apache2 (
  $http_ensure            = $nagios3::http_ensure,
  $https_ensure           = $nagios3::https_ensure,
  $contact_group          = $nagios3::contact_group,
  $apache_warn_min_procs  = $nagios3::apache_warn_min_procs,
  $apache_warn_max_procs  = $nagios3::apache_warn_max_procs,
  $apache_crit_min_procs  = $nagios3::apache_crit_min_procs,
  $apache_crit_max_procs  = $nagios3::apache_crit_max_procs
) inherits nagios3 {

  @@nagios_service { "check_http_${hostname}":
    ensure              => "$http_ensure",
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
    ensure  => "$http_ensure",
    line    => "command[check_procs_web]=/usr/lib/nagios/plugins/check_procs -w $apache_warn_min_procs:$apache_warn_max_procs -c $apache_crit_min_procs:$apache_crit_max_procs -C apache2",
    path    => '/etc/nagios/nrpe.cfg',
    notify  => Service['nagios-nrpe-server'],
    match   => '^command\[check_procs_web\]=\/usr\/lib\/nagios\/plugins\/check_procs -w \d*:\d* -c \d*:\d* -C apache2',
  }

  @@nagios_service { "check_httpd_${hostname}":
    ensure              => "$http_ensure",
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
     ensure              => "$https_ensure",
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
}
