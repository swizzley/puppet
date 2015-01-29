# Class: timecapsule
#
# This module manages timecapsule
#

class timecapsule (
  $repo         = $::timecapsule::params::epel,
  $user         = $::timecapsule::params::user,
  $group        = $::timecapsule::params::group,
  $mount        = $::timecapsule::params::mount,
  $package      = $::timecapsule::params::package,
  $ports        = $::timecapsule::params::ports,
  $services     = $::timecapsule::params::services,
  $avahi_ssh    = $::timecapsule::params::avahi_ssh,
  $install_epel = $::timecapsule::params::use_epel,
  $firewall     = $::timecapsule::params::use_iptables,
  $bonjour_ssh  = $::timecapsule::params::enable_avahi_ssh,
  $manage_user  = $::timecapsule::params::manage_user,
  $manage_group = $::timecapsule::params::manage_group,) inherits timecapsule::params {
  validate_bool($install_epel)
  validate_bool($firewall)
  validate_bool($bonjour_ssh)
  validate_bool($manage_user)
  validate_bool($manage_group)

  if $install_epel {
    exec { 'install EPEL 7 repo': command => 'yum install -y $repo', }
  }

  package { $package: ensure => installed } ->
  service { $services:
    ensure => 'running',
    enable => true,
  }

  file { $mount:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { '/etc/netatalk/afpd.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $::timecapsule::config::afpd,
    require => Package['netatalk'],
    notify  => Service['netatalk'],
  }

  file { '/etc/netatalk/AppleVolumes.default':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => template('timecapsule/AppleVolumes.default.erb'),
    require => Package['netatalk'],
    notify  => Service['netatalk'],
  }

  file { '/etc/avahi/services/afpd.service':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => template('timecapsule/afpd.service.erb'),
    require => Package['avahi'],
    notify  => Service['avahi-daemon'],
  }

  exec { 'nsswitch switch':
    command => 'cp /etc/nsswitch.conf /etc/nsswitch.conf.pre-timecapsule && sed -i "/^hosts:/c\hosts:      files mdns4_minimal dns mdns mdns4" /etc/nsswitch.conf',
    unless  => 'test -f /etc/nsswitch.conf.pre-timecapsule',
  }

  if $bonjour_ssh {
    file { $avahi_ssh:
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
  } else {
    file { $avahi_ssh: ensure => absent, }
  }

  if $firewall {
    firewall { 'enable time capsule':
      port   => $ports,
      proto  => ['tcp', 'udp'],
      action => 'accept',
    }
  }

  if $manage_user {
    user { $user:
      ensure => present,
      gid    => $group
    }
  }

  if $manage_group {
    group { $group: ensure => present, }
  }

}
