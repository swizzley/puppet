# Class: puppet
#
# This module manages puppet
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class puppet {
  package { 'puppet': ensure => installed, } ->
  service { 'puppet':
    ensure  => 'running',
    enable  => true,
  }

}
