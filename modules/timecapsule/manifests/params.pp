# Class: timecapsule::params
#
# This module manages timecapsule
#

class timecapsule::params {
  $user = 'change_me'
  $manage_user = false
  $group = 'change_me'
  $manage_group = false
  $enable_avahi_ssh = false
  $mount = '/mnt/timecapsule'
  $epel = 'http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm'
  $package = $::timecapsule::packages::package
  $ports = $::timecapsule::config::ports
  $services = $::timecapsule::config::services
  $avahi_ssh = $::timecapsule::config::avahi_ssh

}
