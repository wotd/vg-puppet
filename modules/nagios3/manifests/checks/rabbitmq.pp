class nagios3::checks::rabbitmq (
  $rabbitmq_check   = $nagios3::rabbitmq_check,
  $contact_group    = $nagios3::contact_group,
) inherits nagios3 {

  @@nagios_service { "check_rabbitmq_mgnt_${hostname}":
    ensure              => "$rabbitmq_check",
    check_command       => "check_tcp!15672",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_rabbitmq_management",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_rabbitmq_${hostname}":
    ensure              => "$rabbitmq_check",
    check_command       => "check_tcp!5432",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_rabbitmq",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
}
