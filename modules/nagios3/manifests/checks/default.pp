#
class nagios3::checks::default (
  $contact_group    = $nagios3::contact_group,
  $checktime_period = $nagios3::checktime_period
  ) inherits nagios3 {

  @@nagios_host { $fqdn:
    ensure               => 'present',
    alias                => $hostname,
    address              => $ipaddress_eth1,
    use                  => "generic-host",
    max_check_attempts   => '10',
    notification_period  => '24x7',
    check_period         => '24x7',
    notification_options => 'd,u,r',
    contact_groups       => "$contact_group",
    target               => "/etc/nagios3/conf.d/autonagios_hosts.cfg",
}

  @@nagios_service { "check_ping_${hostname}":
    ensure              => 'present',
    check_command       => "check_ping!100.0,20%!500.0,60%",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    service_description => "${hostname}_check_ping",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_load_${hostname}":
    ensure              => 'present',
    check_command       => "check_nrpe_1arg!check_load",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    service_description => "${hostname}_load",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_total_procs_${hostname}":
    ensure              => 'present',
    check_command       => "check_nrpe_1arg!check_total_procs",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    service_description => "${hostname}_check_total_procs",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_zombie_procs_${hostname}":
    ensure              => 'present',
    check_command       => "check_nrpe_1arg!check_zombie_procs",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    service_description => "${hostname}_check_zombie_procs",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_users_${hostname}":
    ensure              => 'present',
    check_command       => "check_nrpe_1arg!check_users",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    service_description => "${hostname}_check_users",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  @@nagios_service { "check_disk_${hostname}":
    ensure              => 'present',
    check_command       => "check_nrpe_1arg!check_disk1",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    service_description => "${hostname}_check_disk",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}

  file { '/usr/lib/nagios/plugins/check_puppet.rb':
    ensure  => 'present',
    source  => 'puppet:///modules/nagios3/check_puppet.rb',
    mode    => '755',
}

  @@nagios_service { "check_puppet_${hostname}":
    ensure              => 'present',
    check_command       => "check_nrpe_1arg!check_puppet",
    use                 => 'generic-service',
    contact_groups      => "$contact_group",
    host_name           => "$fqdn",
    notification_period => '24x7',
    check_period        => '24x7',
    service_description => "${hostname}_puppet_agent",
    max_check_attempts  => '10',
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",

}

  file_line { 'check_disk1':
    ensure  => 'present',
    line    => 'command[check_disk1]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /',
    path    => '/etc/nagios/nrpe_local.cfg',
    require => Class['nagios3::client::install'],
    notify  => Service['nagios-nrpe-server'],
}

  file_line { 'check_puppet':
    ensure  => 'present',
    line    => "command[check_puppet]=sudo /usr/lib/nagios/plugins/check_puppet.rb -w 3600 -c 9000",
    path    => '/etc/nagios/nrpe_local.cfg',
    require => Class['nagios3::client::install'],
    notify  => Service['nagios-nrpe-server'],
    match   => '^command\[check_puppet\]=sudo \/usr\/lib\/nagios\/plugins\/check_puppet.rb -w \d* -c \d*',
}

}
