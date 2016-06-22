define nagios3::checks::script (
  $script_check  = $nagios3::script_check,
  $check_name    = $name,
  $script_name   = 'check_script.sh',
  $script_path   = '/usr/lib/nagios/plugins',
  $contact_group = $nagios3::contact_group,
  $check_warn    = '0',
  $check_crit    = '0'
)  {

file { "$script_path/$script_name":
  ensure => "$script_check",
  mode   => '755',
  source => "puppet:///modules/nagios3/$script_name",
}

file_line { "$check_name":
  ensure  => "$script_check",
  line    => "command[$check_name]=$script_path/$script_name -w $check_warn -c $check_crit",
  path    => '/etc/nagios/nrpe_local.cfg',
  match   => "command[$check_name]",
  notify  => Service['nagios-nrpe-server'],
}

  @@nagios_service { "check_script_${check_name}_${hostname}":
    ensure              => "$script_check",
    check_command       => "check_nrpe_1arg!$check_name",
    use                 => 'generic-service',
    host_name           => "$fqdn",
    notification_period => "24x7",
    check_period        => '24x7',
    service_description => "${hostname}_script_$check_name",
    max_check_attempts  => '10',
    contact_groups      => "$contact_group",
    target              => "/etc/nagios3/conf.d/autonagios_service.cfg",
  }
}
