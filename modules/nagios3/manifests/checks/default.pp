#
class nagios3::checks::default {
@@nagios_host { $fqdn:
  ensure                => present,
  alias                 => $hostname,
  address               => $ipaddress_eth1,
  use                   => "generic-host",
  max_check_attempts    => '10',
  notification_options  => 'd,u,r',
  contact_groups        => "$contact_group",
  target  => "/etc/nagios3/conf.d/autonagios_hosts.cfg",
 }

@@nagios_service { "check_ping_${hostname}":
  check_command       => "check_ping!100.0,20%!500.0,60%",
  use                 => "generic-service",
  host_name           => "$fqdn",
  notification_period => "24x7",
  max_check_attempts    => '10',
  contact_groups        => "$contact_group",
  service_description => "${hostname}_check_ping",
  target  => "/etc/nagios3/conf.d/autonagios_service.cfg",
 }

@@nagios_service { "check_load_${hostname}":
  check_command       => "check_nrpe_1arg!check_load",
  use                 => "generic-service",
  host_name           => "$fqdn",
  notification_period => "24x7",
  max_check_attempts    => '10',
  contact_groups        => "$contact_group",
  service_description => "${hostname}_load",
  target  => "/etc/nagios3/conf.d/autonagios_service.cfg",
 }

@@nagios_service { "check_total_procs_${hostname}":
  check_command => "check_nrpe_1arg!check_total_procs",
  use => "generic-service",
  host_name => "$fqdn",
  max_check_attempts    => '10',
  contact_groups        => "$contact_group",
  service_description => "${hostname}_check_total_procs",
  target  => "/etc/nagios3/conf.d/autonagios_service.cfg",
 }

@@nagios_service { "check_zombie_procs_${hostname}":
  check_command => "check_nrpe_1arg!check_zombie_procs",
  use => "generic-service",
  host_name => "$fqdn",
  max_check_attempts    => '10',
  contact_groups        => "$contact_group",
  service_description => "${hostname}_check_zombie_procs",
  target  => "/etc/nagios3/conf.d/autonagios_service.cfg",
 }

@@nagios_service { "check_users_${hostname}":
  check_command => "check_nrpe_1arg!check_users",
  use => "generic-service",
  host_name => "$fqdn",
  max_check_attempts    => '10',
  contact_groups        => "$contact_group",
  service_description => "${hostname}_check_users",
  target  => "/etc/nagios3/conf.d/autonagios_service.cfg",
 }


file_line { 'check_disk1':
  line    => 'command[check_disk1]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /',
  path    => '/etc/nagios/nrpe_local.cfg',
  notify  => Service['nagios-nrpe-server'],
  ensure              => 'present',
}

@@nagios_service { "check_disk_${hostname}":
  check_command => "check_nrpe_1arg!check_disk1",
  use => "generic-service",
  host_name => "$fqdn",
  max_check_attempts    => '10',
  contact_groups        => "$contact_group",
  service_description => "${hostname}_check_disk",
  target  => "/etc/nagios3/conf.d/autonagios_service.cfg",
 }
}
