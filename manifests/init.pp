# == Class: func
#
# This class installs and configures the func server/minions.
#
class func (
  $master_dir                  = $func::params::master_dir,
  $func_dir                    = $func::params::func_dir,
  $ensure											 = $func::params::ensure,
  $func_conf_template          = $func::params::func_conf_template,
  $func_minion_template			   = $func::params::func_minion_template,
  $func_master_template			 	 = $func::params::func_master_template,
  $func_minion                 = $func::params::func_minion,
  $func_master               	 = $func::params::func_master,
  $certmaster		       				 = $func::params::certmaster,
  $certmaster_ip	             = $func::params::certmaster_ip,
) inherits func::params {

  class { 'func::install': } ~>
  class { 'func::config': } ->
  Class['func']
}
