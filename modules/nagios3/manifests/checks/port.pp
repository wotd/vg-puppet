define nagios3::checks::port (
  $port          ='80',
  $check_name    = $name,
  $contact_group = $nagios3::contact_group,
  $port_check    = $nagios3::port_check
) {
  @@nagios_service { "check_port_${check_name}_${hostname}":
    ensure              => "$port_check",
    check_command       => "check_tcp!$port",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_tcp_$check_name",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
}
