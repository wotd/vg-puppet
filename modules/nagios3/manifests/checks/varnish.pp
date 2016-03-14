class nagios3::checks::varnish (
  $varnish_check = $nagios3::varnish_check,
  $contact_group = $nagios3::contact_group
) inherits nagios3 {

  file_line { 'check_procs_varnish':
    ensure => "$varnish_check",
    line   => 'command[check_procs_varnish]=/usr/lib/nagios/plugins/check_procs -w 2:2 -c 2:4 -C varnishd',
    path   => '/etc/nagios/nrpe_local.cfg',
    notify => Service['nagios-nrpe-server'],
}

  @@nagios_service { "check_varnishd_${hostname}":
    ensure              => "$varnish_check",
    check_command       => "check_nrpe_1arg!check_procs_varnish",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    max_check_attempts  => '10',
    service_description => "${hostname}_varnishd",
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_varnish_http_${hostname}":
    ensure              => "$varnish_check",
    check_command       => "check_http",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    max_check_attempts  => '10',
    service_description => "${hostname}_varnish_http",
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_varnish_https_${hostname}":
    ensure              => "$varnish_check",
    check_command       => "check_tcp!443",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_varnish_https",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
  Class['nagios3::client::install'] -> Class['nagios3::checks::varnish']
}
