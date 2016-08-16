# Handles iptables concerns.  
class iptables {
  include iptables::config, iptables::service
}

