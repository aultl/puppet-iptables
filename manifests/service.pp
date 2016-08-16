# iservice.pp - installs required packges and manages service
class iptables::service inherits iptables {

  package { "iptables":
    ensure  => present,
    require => Repo['jtv-base'],
  }
  
  if ( $::operatingsystemmajrelease == '7') {
    package { "iptables-services":
      ensure  => present,
      require => Repo['base'],
    }
  
    $service_require = [ Package['iptables'], Package['iptables-services'] ]
  } else {
    $service_require = Package['iptables']
  }
  
  service { 'iptables':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => $service_require,
  }

  exec { "rebuild_iptables":
    command     => "/usr/sbin/rebuild-iptables",
    require     => File["/usr/sbin/rebuild-iptables"],
    refreshonly => true,
  }

}
