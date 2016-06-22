#TODO - port checks should be able to auto-delete
#TODO - move entries from nrpe.cfg to nrpe_local.cfg
class nagios3::params {
  #Client Params
  $nagios_server_ip       = "192.168.50.50"
  #Server config
  $contact_group_name     = 'hosting-cs'
  $contact_group_members  = 'root'
  #Checks Params
  $contact_group          = 'hosting-cs'
  $checktime_period       = '24x7'
  #APACHE
  $apache_check           = 'present'
  $apaches_check          = 'present'
  $apache_warn_min_procs  = '5'
  $apache_warn_max_procs  = '20'
  $apache_crit_min_procs  = '2'
  $apache_crit_max_procs  = '21'
  #MYSQL
  $mysql_check            = 'present'
  #POSTGRESQL
  $postgresql_check       = 'present'
  $ps_warn_min_procs      = '3'
  $ps_warn_max_procs      = '8'
  $ps_crit_min_procs      = '0'
  $ps_crit_max_procs      = '11'
  #RABBITMQ
  $rabbitmq_check         = 'present'
  #VARNISH
  $varnish_check          = 'present'
  #SMTP
  $smtp_check             = 'present'
  #CASSANDRA
  $cassandra_check        = 'present'
  #Port
  $port_check             = 'present'
  #HADOOP
  $hadoop_lh_check        = 'present'
  $hadoop_lm_check        = 'present'
  $hadoop_jt_check        = 'present'
  $hadoop_nn_check        = 'present'
  $hadoop_tt_check        = 'present'
  $hadoop_2nn_check       = 'present'
  #TOMCAT
  $tomcat_check           = 'present'
  #SCRIPT
  $script_check           = 'present'
}
