class puppet {
  include puppet::helloworld
  
  service { 'puppet': 
  ensure     => true,
  binary     => "/usr/bin/puppet",
  enable     => true,
  #flags      => # Specify a string of flags to pass to the startup 
  hasrestart => true,
  hasstatus  => true,
  manifest   => "puppet agent -t",
  path       => "/usr/bin",
  provider   => redhat,
  restart    => "service puppet restart",
  start      => "service puppet start",
  status     => "service puppet status",
  stop       => false,
  tag        => ["helloworld","changeme"],
  
  }

}
