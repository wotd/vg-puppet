#
class nagios3::server::contactgroup (
  $contact_group_name     = $nagios3::server::contact_group_name,
  $contact_group_members  = $nagios3::server::contact_group_members
  ) inherits nagios3::server {

  nagios_contactgroup { "$contact_group_name":
    ensure            => 'present',
    contactgroup_name => "$contact_group_name",
    members           => "$contact_group_members",
    target            => '/etc/nagios3/conf.d/autonagios_contactgroups.cfg',
    notify            => Class['nagios3::server::service'],
    require           => Class['nagios3::server::install']
  }
}
