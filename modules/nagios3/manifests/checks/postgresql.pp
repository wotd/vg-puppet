class nagios3::checks::postgresql (
  $postgresql_check  = $nagios3::postgresql_check,
  $contact_group     = $nagios3::contact_group,
  $ps_warn_min_procs = $nagios3::ps_warn_min_procs,
  $ps_warn_max_procs = $nagios3::ps_warn_max_procs,
  $ps_crit_min_procs = $nagios3::ps_crit_min_procs,
  $ps_crit_max_procs = $nagios3::ps_crit_max_procs
) inherits nagios3 {

  file_line { 'check_procs_postgresql':
    ensure  => "$postgresql_check",
    line    => "command[check_procs_postgresqld]=/usr/lib/nagios/plugins/check_procs -w $ps_warn_min_procs:$ps_warn_max_procs -c $ps_crit_min_procs:$ps_crit_max_procs -C postgres",
    path    => '/etc/nagios/nrpe.cfg',
    notify  => Service['nagios-nrpe-server'],
    match   => '^command\[check_procs_postgresqld\]=\/usr\/lib\/nagios\/plugins\/check_procs -w \d*:\d* -c \d*:\d* -C postgres',
}


  @@nagios_service { "check_postgresqld_${hostname}":
    ensure              => "$postgresql_check",
    check_command       => "check_nrpe_1arg!check_procs_postgresqld",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_postgresqld",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_postgresql_${hostname}":
    ensure              => "$postgresql_check",
    check_command       => "check_tcp!5432",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_postgresql_tcp",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

}
