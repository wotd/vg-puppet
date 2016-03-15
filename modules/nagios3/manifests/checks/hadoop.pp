class nagios3::checks::hadoop (
  $hadoop_lh_check  = $nagios3::hadoop_lh_check,
  $hadoop_lm_check  = $nagios3::hadoop_lm_check,
  $hadoop_jt_check  = $nagios3::hadoop_jt_check,
  $hadoop_nn_check  = $nagios3::hadoop_nn_check,
  $hadoop_tt_check  = $nagios3::hadoop_tt_check,
  $hadoop_2nn_check = $nagios3::hadoop_2nn_check,
  $contact_group    = $nagios3::contact_group,
) inherits nagios3 {

  nagios3::checks::port { 'Hadoop JobTracker':
    port_check => "$hadoop_jt_check",
    port       => '50030',
  }
  nagios3::checks::port { 'Hadoop NameNode':
    port_check => "$hadoop_nn_check",
    port       => '50070',
  }
  nagios3::checks::port { 'Hadoop TaskTracker':
    port_check => "$hadoop_tt_check",
    port       => '50060',
  }
  nagios3::checks::port { 'Hadoop Secondary NameNode':
    port_check => "$hadoop_2nn_check",
    port       => '50090',
  }

  file { '/usr/lib/nagios/plugins/check_last_hour_data.sh':
    ensure => "$hadoop_lh_check",
    mode   => '755',
    source => 'puppet:///modules/nagios3/check_last_hour_data.sh',
  }
  file { '/usr/lib/nagios/plugins/check_last_min_data2.sh':
    ensure => "$hadoop_lm_check",
    mode   => '755',
    source => 'puppet:///modules/nagios3/check_last_min_data2.sh'
  }
  file_line { 'check_hadoop_last_hour_data':
    ensure => "$hadoop_lh_check",
    line   => 'command[check_hadoop_last_hour_data]=/usr/lib/nagios/plugins/check_last_hour_data.sh',
    path   => '/etc/nagios/nrpe_local.cfg',
    notify => Service['nagios-nrpe-server'],
}
  file_line { 'check_hadoop_last_min_data':
    ensure => "$hadoop_lm_check",
    line   => 'command[check_hadoop_last_min_data]=/usr/lib/nagios/plugins/check_last_min_data2.sh',
    path   => '/etc/nagios/nrpe_local.cfg',
    notify => Service['nagios-nrpe-server'],
  }
  Class['nagios3::client::install'] -> Class['nagios3::checks::hadoop']
}
