# Handles iptables concerns.  See also ipt_fragment definition
#
# Les Ault <les.ault@jtv.com>
#
# PURPOSE: Manages files in the /etc/iptables.d dirctory
#          and executes a rebuild-iptables script to build
#          a fully baked firewall policy (in the *filter chain)
#
# USAGE:
# If you want to open port 22/tcp call this function like so:
#
# iptables::rule { 'ssh' :
#   action   => 'accept',
#   dport    => '22',
#   chain    => 'RH-Firewall', <-- case sensitive
#   comment  => 'Optional Field',
#   protocol => 'tcp', <-- valid values are ['tcp', 'udp', 'both']
#   state    => 'NEW', <-- valid values are ['new', 'established', 'related']
#   table    => 'filter', <-- valid values are ['nat', 'filter']
# }
#
#
 

define iptables::rule (
  $comment  = '',
  $chain    = 'RH-Firewall',
  $protocol = 'tcp',
  $state    = 'new',
  $table    = 'filter',
  $action,
  $dport,
){
  include ::iptables

  file { "/etc/iptables.d/${table}_${name}":
    ensure  => present,
    content => template("${module_name}/${table}_rule.erb"),
    require => File['/etc/iptables.d'],
    notify  => Exec['rebuild_iptables'],
  }

  validate_array_member($action, ['accept','log', 'drop'])
  validate_array_member($protocol, ['tcp','udp','both'])
  validate_array_member($state, ['new','established','related'])
  validate_array_member($table, ['filter','nat'])
}
 
