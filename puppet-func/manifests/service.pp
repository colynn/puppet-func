# Set up the func minion as a service
class func::service {
  if $func::func_minion {
    service {'funcd':
    name      => $func::params::service_func_name,
    enable => true,
    ensure => running,
    #hasstatus => true,
    require   => Class['func::install'],
    }
    service {'certmaster':
    name      => $func::params::service_master_name,
    enable => false,
#    ensure => stopped,
    }
  }
  
  if $func::func_master {
    service {'certmaster':
    name      => $func::params::service_master_name,
    enable => true,
    ensure => running,
    hasstatus => true,
    require   => Class['func::install'],
    }
  }
}
