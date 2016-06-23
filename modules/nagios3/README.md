# nagios3

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nagios3](#setup)
    * [What nagios3 affects](#what-nagios3-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nagios3](#beginning-with-nagios3)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

nagios3 module is puppet module that can be used to deploy and maintain nagios3 monitoring tool. It can be used to configure server and checks on particular hosts.

## Module Description

nagios3 module can be used to:
1. Install and perform initial configuration for nagios3 monitoring tool
2. Configure checks for following servers and technologies:
    * apache2
    * cassandra
    * hadoop
    * mysql
    * postgresql
    * rabbitmq
    * smtp
    * tomcat
    * varnish
    * network port
    * custom script
    * default checks like disk space, cpu, puppet agent
3. Install plugins required by client machines to work with Nagios.

## Setup

### What nagios3 affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

N/A

### Beginning with nagios3

#### Server

To install nagios3 monitoring server just use following code:
```
include nagios3::server
```

This will deploy server with following credentials:
  - Username: *nagiosadmin*
  - Password: *2*

To change password, use htpasswd manually and comment out section in nagios3/manifests/server/config.pp file.
```
htpasswd /etc/nagios3/htpasswd.users nagiosadmin
```
Now server is accessible on http://ip_address/nagios3

All setting and checks configured by module are located in separated files:
/etc/nagios3/conf.d/autonagios_contactgroups.cfg
/etc/nagios3/conf.d/autonagios_hosts.cfg
/etc/nagios3/conf.d/autonagios_service.cfg

#### Client

Following command will install and configure nrpe plugin. Please remember about updating params.pp file and configure IP address of nagios server you want to use. This IP will be whitelisted in nrpe configuration.

```
include nagios3
```

This command will enable following checks:
  - check_ping
  - check_load
  - check_total_procs
  - check_zombie_procs
  - check_users
  - check_disk1
  - check_puppet
  - check_ssh (if Linux)

if you want install only nrpe client without enabling default checks use this command:
```
include nagios3::client
```

## Usage

All following classes can be declared like this:
```
include nagios3::checks::apache2
```
Or default values can be modified to suit your need.

*It is important to apply puppet on client machine before applying it on nagios server.*

### apache2

```
class { 'nagios3::checks::apache2':
    apache_check           => 'present',
    apaches_check          => 'present',
    apache_warn_min_procs  => '5',
    apache_warn_max_procs  => '20',
    apache_crit_min_procs  => '2',
    apache_crit_max_procs  => '21'
  }
```

### cassandra

This check can be only disabled or enabled. In fact it is deploying script to check cassandra. Script can be found in files directory.
```
class { 'nagios3::checks::cassandra':
  cassandra_check           => 'present'
  }
```

### hadoop

```
class { 'nagios3::checks::hadoop':
    hadoop_lh_check        => 'present',
    hadoop_lm_check        => 'present',
    hadoop_jt_check        => 'present',
    hadoop_nn_check        => 'present',
    hadoop_tt_check        => 'present',
    hadoop_2nn_check       => 'present'
  }
```

### mysql

```
  class { 'nagios3::checks::mysql':
    mysql_check            => 'present'
  }
```
### postgresql

```
class { 'nagios3::checks::postgresql':
    postgresql_check       => 'present',
    ps_warn_min_procs      => '3',
    ps_warn_max_procs      => '8',
    ps_crit_min_procs      => '0',
    ps_crit_max_procs      => '11'
  }
```

### rabbitmq

```
class { 'nagios3::checks::rabbitmq':
    rabbitmq_check         => 'present'
  }
```

### smtp

```
class { 'nagios3::checks::smtp':
    smtp_check             => 'present'
  }
```

### tomcat

```
class { 'nagios3::checks::tomcat':
    tomcat_check           => 'present'
  }
```

### varnish

```
class { 'nagios3::checks::varnish':
    varnish_check          => 'present'
  }
```

### network port

```
nagios3::checks::port { 'webserver':
    port_check             => 'present',
    port                   => '80',
    contact_group          => 'hosting-cs'
  }
```

### custom script

Script has to be deployed in files directory. *script_name* is name of the file, *script_path* is path where script will be deployed. Name of this check (*apache_lines* in this example) will be added to nrpe file. Remember do delete old entries (or entire file) if you change something here. Module contains example script that can be used as a pattern.
```
nagios3::checks::script { 'apache_lines':
    script_check  => 'present',
    script_name   => 'check_script.sh',
    script_path   => '/usr/lib/nagios/plugins',
    contact_group => 'hosting-cs',
    check_warn    => '0',
    check_crit    => '0'
  }
```

### default checks

```
class { '':
    contact_group    => 'hosting-cs',
    checktime_period => '24x7'
  }
```

## Reference

* Main classes
  * nagios3::client
  * nagios3::checks
  * nagios3::server
* Checks classes
  * apache2
  * cassandra
  * default checks
  * hadoop    
  * mysql
  * postgresql
  * rabbitmq
  * smtp
  * tomcat
  * varnish
* Defined types
  * network port
  * custom script

## Limitations

Module is working on Ubuntu machines. It was not tested on Centos / RHEL. But who nows...? :)
