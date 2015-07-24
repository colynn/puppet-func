# Default parameters
class mcollective::params
{
  # Basic config
  $ensure              = 'present'
  $dir                 = '/etc/mcollective'
  $package1            = 'mcollective-common'
  $mco_puppet_package1 = 'mcollective-puppet-common'
  $server_name 	       = 'mcollective'
  $puppet_agent        = true
  
  $activemq_host       = '118.242.16.52'
  $activemq_port       = 61613
  $activemq_user       = mcollective
  $activemq_password   = 'game1232014'
  $activemq_hb_interval = 30
  $activemq_reconn_attempts = 5


  # Need your own config templates? Specify here:
  $server_template  = 'mcollective/server.cfg.erb'
  $client_template  = 'mcollective/client.cfg.erb'
  
  $puppet_master = str2bool($puppet_agent) ? {
    true   => false,
    default => true,
  }
  
  if $puppet_agent {
       $package2            = 'mcollective'
       $mco_puppet_package2 = 'mcollective-puppet-agent'
  } else {
       $package2            = 'mcollective-client'
       $mco_puppet_package2 = 'mcollective-puppet-client'
  } 
}
