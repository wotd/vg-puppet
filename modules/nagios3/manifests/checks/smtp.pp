class nagios3::checks::smtp (
  $smtp_check    = $nagios3::smtp_check,
  $contact_group = $nagios3::contact_group,
) inherits nagios3 {
  @@nagios_service { "check_smtp_${hostname}":
    ensure              => "$smtp_check",
    check_command       => "check_smtp",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_smtp",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
  Class['nagios3::client::install'] -> Class['nagios3::checks::smtp']
}
