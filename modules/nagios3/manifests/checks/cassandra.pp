class nagios3::checks::cassandra (
  $cassandra_check    = $nagios3::cassandra_check,
  $contact_group      = $nagios3::contact_group,
) inherits nagios3 {

  file { '/usr/lib/nagios/plugins/check_cassandra_cluster.sh':
    ensure => "$cassandra_check",
    mode   => '755',
    source => 'puppet:///modules/nagios3/check_cassandra_cluster.sh',
}

  file_line { 'check_cassandra_cluster':
    ensure => "$cassandra_check",
    line    => 'command[check_cassandra_cluster]=/usr/lib/nagios/plugins/check_cassandra_cluster.sh -w 0 -c 0',
    path    => '/etc/nagios/nrpe_local.cfg',
    notify  => Service['nagios-nrpe-server'],
}

  @@nagios_service { "check_cassandra_cluster_${hostname}":
    ensure              => "$cassandra_check",
    check_command       => "check_nrpe_1arg!check_cassandra_cluster",
    use                 => "generic-service",
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_cassandra_cluster",
    max_check_attempts  => '10',
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
}
}
