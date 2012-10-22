#
# This puppet manifest is already applied first to do some environment specific things
#
file { '/etc/resolv.conf':
        content => 'nameserver 8.8.8.8',
}

file { '/etc/apt/apt.conf.d/99unauth':
        content => 'APT::Get::AllowUnauthenticated 1;',
}
file {'/etc/apt/source.list':
	source => 'deb http://mirrors.163.com/ubuntu/ precise main universe restricted multiverse \
	deb http://mirrors.163.com/ubuntu/ precise-security universe main multiverse restricted \
	deb http://mirrors.163.com/ubuntu/ precise-updates universe main multiverse restricted \
	deb http://mirrors.163.com/ubuntu/ precise-proposed universe main multiverse restricted \
	deb http://mirrors.163.com/ubuntu/ precise-backports universe main multiverse restricted',
}


apt::source { 'openstack_folsom':
  location          => "http://ubuntu-cloud.archive.canonical.com/ubuntu",
  release           => "precise-updates/folsom",
  repos             => "main",
  required_packages => 'ubuntu-cloud-keyring',
}

#
# configure apt to use my squid proxy
# I highly recommend that anyone doing development on
# OpenStack set up a proxy to cache packages.
#
#class { 'apt':
#  proxy_host => '172.16.0.1',
#  proxy_port => '3128',
}

# an apt-get update is usally required to ensure that
# we get the latest version of the openstack packages
exec { '/usr/bin/apt-get update':
#  require     => Class['apt'],
  refreshonly => true,
  subscribe   => [ Apt::Source["openstack_folsom"]],
  logoutput   => true,
}

#
# specify a connection to the hardcoded puppet master
#
host {
  'puppet':              ip => '172.16.0.2';
  'openstackcontroller': ip => '172.16.0.3';
  'compute1':            ip => '172.16.0.4';
  'novacontroller':      ip => '172.16.0.5';
  'glance':              ip => '172.16.0.6';
  'keystone':            ip => '172.16.0.7';
  'mysql':               ip => '172.16.0.8';
  'cinderclient':        ip => '172.16.0.9';
  'quantumagent':        ip => '172.16.0.10';
}

group { 'puppet':
  ensure => 'present',
}

# bring up the bridging interface explicitly
#exec { '/sbin/ifconfig eth2 up': }

node default { }
