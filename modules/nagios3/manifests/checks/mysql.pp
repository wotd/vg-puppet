class nagios3::checks::mysql (
  $mysql_check   = $nagios3::mysql_check,
  $contact_group = $nagios3::contact_group,
) inherits nagios3 {

  file_line { 'check_procs_mysql':
    ensure => "$mysql_check",
    line   => 'command[check_procs_mysql]=/usr/lib/nagios/plugins/check_procs -w 1:1 -c 1:3 -C mysqld',
    path   => '/etc/nagios/nrpe_local.cfg',
    notify => Service['nagios-nrpe-server'],
}

  @@nagios_service { "check_mysqld_${hostname}":
    ensure              => "$mysql_check",
    check_command       => "check_nrpe_1arg!check_procs_mysql",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_mysqld",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  file_line { 'check_mysql':
    ensure => "$mysql_check",
    line   => 'command[check_mysql]=/usr/lib/nagios/plugins/check_mysql -u nagios -pnagios123 -Hlocalhost -dnagios_test',
    path   => '/etc/nagios/nrpe_local.cfg',
    notify => Service['nagios-nrpe-server'],
}

@@nagios_service { "check_mysql_${hostname}":
  ensure              => "$mysql_check",
  check_command       => "check_nrpe_1arg!check_mysql",
  use                 => 'generic-service',
  host_name           => "$fqdn",
  notification_period => "24x7",
  check_period        => '24x7',
  service_description => "${hostname}_mysql",
  max_check_attempts  => '10',
  contact_groups      => "$contact_group",
  target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
  Class['nagios3::client::install'] -> Class['nagios3::checks::mysql']
}
