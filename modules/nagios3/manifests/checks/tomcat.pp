class nagios3::checks::tomcat (
  $tomcat_check   = $nagios3::mysql_check,
  $contact_group  = $nagios3::contact_group,
) inherits nagios3 {
  nagios3::checks::port { 'tomcat_8080':
    port_check => "$tomcat_check",
    port       => '8080',
  }
  file_line { 'check_procs_tomcat':
    ensure => "$mysql_check",
    line   => 'command[check_procs_tomcat]=/usr/lib/nagios/plugins/check_procs -w 1:1 -c 1:3 -C java',
    path   => '/etc/nagios/nrpe_local.cfg',
    notify => Service['nagios-nrpe-server'],
}
  @@nagios_service { "check_tomcat_${hostname}":
    ensure              => "$tomcat_check",
    check_command       => "check_nrpe_1arg!check_procs_tomcat",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_tomcat",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
  Class['nagios3::client::install'] -> Class['nagios3::checks::tomcat']
}
