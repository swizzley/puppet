# timecapsule #

** Table of Contents **
- [timecapsule #](#timecapsule-)
    - [Overview ##](#overview-)
    - [Module Description ##](#module-description-)
    - [Setup ##](#setup-)
            - [Presumptions ####](#presumptions-)
            - [Credentials ####](#credentials-)
    - [Usage ##](#usage-)
            - [Server ####](#server-)
            - [Client ####](#client-)
            - [Considerations ####](#considerations-)
    - [Troubleshooting ##](#troubleshooting-)
            - [selinux ####](#selinux-)
            - [Mac ####](#mac-)
            - [Notes ####](#notes-)
    - [Requirements ##](#requirements-)
    - [Compatibility ##](#compatibility-)
    - [Limitations ##](#limitations-)
    - [TODO ##](#todo-)
    - [Changelog ##](#changelog-)
    - [License ##](#license-)
    - [Contact ##](#contact-)
    - [Development ##](#development-)

## Overview ##

This is the timecapsule module. It provides an open-source "Time Capsule" to be
used for OSX automated backups via the "Time Machine".


## Module Description ##

The timemachine module turns your Redhat based system into a Time Machine server.
It depends on netatalk 2.2.3 rpm which is included by in the fedora repo but not
in EPEL or BASE of RHEL/CentOS. Therefore an external mirror is used to download 
the package (netatalk-2.2.3-9.fc20) from www.rpmfind.net for CentOS/RHEL systems.


## Setup ##

#### Presumptions ####

The timemachine module requires layer 2 connectivity from your Mac to your time
capsule server for announcements. Your timecapsule server will need to be able 
to access the web to download the required packages, and this module assumes
you are not using a proxy, if you are, you will need to configure that manually.


#### Credentials ####

Even if $manage_user and $manage_group are set to false (defaut), you still need
to set the $user and $group to a valid system user, with a valid password. In
order to set your password hash to be managed, use the following command:
```bash
openssl passwd -crypt "changeme"
```

Then you can configure the following in the params class:
```ruby
class timecapsule::params{
  $user  = 'changeme'
  $group = 'changeme'
  $password = 'FGuWhH516rsQg' #this equals "changeme" 
}
```


## Usage ##

#### Server ####
```ruby
include timecapsule
```

#### Client ####

From your Mac, open finder and you should see your server, click it and if the
user you're logged in as doesn't exist on that server, or you specified a some
other user in the params, you need click connect in the upper right hand corner.
Use the credentials for your user, or the ones you configured in params to 
connect to the server in finder. You should see your $mount directory. Then you
can simply open up Time Machine from the settings menu and flip it on, you will
see the name of your timecapsule server and the disk icon, select it, and voila.


#### Considerations ####

If you use a spacewalk or satellite server for package management, or just plain
don't want to enable the whole repo because you want to download and install the
requirements manually for some reason, then just disable the $use_epel in params.

```ruby
class timecapsule::params{
  $use_epel = false
}
```

If you know you have the RPM-GPG-KEY-EPEL-7 key installed, by all means enable 
gpgcheck in params, it's disabled by default, so this module always works.

```ruby
class timecapsule::params{
  $epel_gpgcheck = true
}
```


## Troubleshooting ##

#### selinux ####

selinux was completely ignored, so maybe start there...
`setenfoce 0`


#### Mac ####

Close "settings" on your Mac and re-open it for Time Machine to rescan/listen. 

If you are connecting through finder, but Time Machine still doesn't find your
server, then bounce the services a couple times on the server. This worked for 
me, I had to bounce them a few times until they all stopped & started OK.

```bash
/sbin/service avahi-daemon restart
/sbin/service messagebus restart
/sbin/service netatalk restart
```


#### Notes ####

Repeating this 2 to 3 times did the trick for me, after the module does its' 
thing. This was only necessary for the initial setup, since then everything has
been online and totoally functional... I backed up 500GB over 802.11b in about 
5 days.  


## Requirements ##

puppetlabs/stdlib >= 4.2.0 

puppetlabs/firewall >= 1.1.3 


## Compatibility ##

  * RHEL 7
  * CentOS 7
  * Fedora 20


## Limitations ##

This module has been tested on:

Server: 
  - Fedora 20
  - CentOS 7 

Client: 
  - OSX 10.10.2 (Yosemite)

This module should work on:

Server: 
  - Fedora 21
  - CentOS 7.1
  - RHEL Server 7.x
  - RHEL Client 7.x
  - RHEL Workstation 7.x 
	
Client: 
  - OSX 10.10.x (Yosemite)
  - OSX 10.9.x  (Maverics)
  - OSX 10.8.x  (Mountain Lion)
  - OSX 10.7.x  (Lion)
  - OSX 10.6.x  (Snow Leopard)
  - OSX 10.5.x  (Leopard)
	 

## TODO ##

  * Add support for Debian operating system family
  * Depricate download netatalk from rpmfind for CentOS/RHEL
  * Add support for netatalk >= 3.0.0
  * Add selinux support
  * Add gpg key install for epel and enable gpgcheck by default
 
  
## Changelog ##

1.0.1 
  - wrapped vars in curlys
  - added exec:unless for centos netatalk download
  - added yumrepo class for epel to ensure enabled, gpgcheck set to false
  - install_epel now enabled by default
  - changed epel-release url to https
  - added default password for $user 


## License ##

Apache-2.0 License


## Contact ##

Email:  morgan@aspendenver.org

WWW:    www.aspendenver.org

Github: https://github.com/swizzley


## Development ##

Any updates or contibutions are welcome.

Report any issues with current release, as any input will be considered valuable.
