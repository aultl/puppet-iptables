# puppet-iptables

This puppet module was written to install, configure, and start iptables

#usage

iptables::rule { 'sshd' :
  action   => 'accept',
  dport    => '22',
  chain    => 'RH-Firewall',
  protocol => 'tcp',
  state    => 'new',
  table    => 'filter',
}




