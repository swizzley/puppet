class puppet::facter::changeme::env {
  
  # ## This is a super jankey way to restrict logins per environment
  # ## But is unfortunately necessary because here at...
  # ## Everyone at the company knows the passwords to the system users

  # ## We need this ssh-key to get the environment fact from satellite
  file { "/var/lib/puppet/lib/facter/changeme_facter_rsa":
    ensure => "present",
    mode   => '0600',
    owner  => "root",
    group  => "root",
    source => "puppet:///modules/puppet/facter/changeme_facter_rsa",
  }

  file { "/etc/puppet/changeme_facter_rsa":
    ensure => "present",
    mode   => '0600',
    owner  => "root",
    group  => "root",
    source => "puppet:///modules/puppet/facter/changeme_facter_rsa",
  }
  
}
