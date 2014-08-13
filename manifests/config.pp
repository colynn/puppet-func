# Set up the func config
class func::config {
  if $func::func_minion {
   host { "$hostname":
        name => "$fqdn",
        ensure => present,
        ip => "$ipaddress",
        target => '/etc/hosts',
   }
   host { "sh_master_18_70.gc73.com.cn":
   		 comment => "func master",
   		 ensure => present,
       ip => "$certmaster_ip",
       target => '/etc/hosts',
   }
   
  file { $func::func_dir:
    ensure => directory,
  } ->
  file { "${func::func_dir}/minion.conf":
    content => template($func::func_conf_template),
  } ~>
  file { "${func::master_dir}/minion.conf":
    content => template($func::func_minion_template),
  } ~>
  class { "func::service": }
  }

  if $func::func_master {
  file { $func::master_dir:
    ensure => directory,
  } ->
  file { "${func::master_dir}/certmaster.conf":
    content => template($func::func_master_template),
  } ~>
  file { "${func::master_dir}/minion.conf":
    content => template($func::func_minion_template),
  } ~>
  class { "func::service": }
  }
}
