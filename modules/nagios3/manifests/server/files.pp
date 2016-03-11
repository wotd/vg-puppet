#
class nagios3::server::files {

  file { "/etc/nagios3/conf.d/autonagios_service.cfg":
      owner => "root",
      group => "root",
      mode  => "644",
  }

  file { "/etc/nagios3/conf.d/autonagios_hosts.cfg":
      owner => "root",
      group => "root",
      mode  => "644",
  }


  file { "/etc/nagios3/conf.d/autonagios_contactgroup.cfg":
      owner => "root",
      group => "root",
      mode  => "644",
  }

  file { "/etc/nagios3/conf.d/autonagios_contacts.cfg":
      owner => "root",
      group => "root",
      mode  => "644",
}

  file { "/etc/nagios3/conf.d/autonagios_commands.cfg":
      owner => "root",
      group => "root",
      mode  => "644",
  }

  file { "/etc/nagios3/conf.d/autonagios_hostgroups.cfg":
      owner => "root",
      group => "root",
      mode  => "644",
  }
}
