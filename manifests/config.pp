# config.pp - configures none iptables services 
class iptables::config {
  file { "/usr/sbin/rebuild-iptables":
    ensure => file,
    mode   => 755,
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/${module_name}/rebuild-iptables",
  }

  # Log iptables drops  
  file { "/etc/rsyslog.d/iptables.conf":
    ensure  => present,
    mode    => 640,
    content => '# Log iptable rules to /var/log/iptables
if $syslogfacility-text == \'kern\' and $msg contains \'IPT \' then /var/log/iptables
& ~'
  }
 
  # make sure we rotate the iptables log
  file { "/etc/logrotate.d/iptables" :
    ensure  => present,
    mode    => 640,
    source  => "puppet:///modules/${module_name}/iptables.logrotate",
  }

  file { "/etc/iptables.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
    force   => true,
    source  => "puppet:///modules/${module_name}/empty",
  }
}
