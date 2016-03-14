#
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
}
