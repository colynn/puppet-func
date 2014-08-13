# Default parameters
class func::params
{
  # Basic config
  $ensure              = 'present'
  $master_dir          = '/etc/certmaster'
  $func_dir						 = '/etc/func'
  $server_func_name    = 'funcd'
  $service_master_name = 'certmaster'
  $certmaster					 = 'sh_master_18_70.gc73.com.cn'
  $certmaster_ip		   = '118.242.2.230'
  $func_minion		     = true
  
  # Need your own config templates? Specify here:
  $func_conf_template    = 'func/minion.conf.erb'
  $func_minion_template = 'func/func_minion.conf.erb'
  $func_master_template  = 'func/func_master.conf.erb'
  
  $func_master = str2bool($func_minion) ? {
    true   => false,
    default => true,
  }
}
