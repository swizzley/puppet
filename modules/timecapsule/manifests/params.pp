# Class: timecapsule::params
#
# This module manages timecapsule
#

class timecapsule::params (
  $ports        = $::timecapsule::config::ports,
  $services     = $::timecapsule::config::services,
  $avahi_ssh    = $::timecapsule::config::avahi_ssh,
  $afpd         = $::timecapsule::config::afpd,
  $package      = $::timecapsule::config::package,
  $netatalk_url = $::timecapsule::config::netatalk_url) inherits timecapsule::config {
  $user = 'changeme'
  $password = 'FGuWhH516rsQg' #this equals "changeme" 
  $manage_user = false
  $group = 'changeme'
  $manage_group = false
  $enable_avahi_ssh = false
  $mount = '/mnt/timecapsule'
  $use_iptables = true
  $use_epel = true
  $epel = 'https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm'
  $epel_gpgcheck = false

}
