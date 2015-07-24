# == Class: mcollective
#
# This class installs and configures the mcollective server.
#
# === Parameters:
#
# $version::                       Specify a specific version of a package to
#                                  install. The version should be the exact
#                                  match for your distro.
#                                  You can also use certain values like 'latest'.
#
# $dir::                           Override the mcollective directory.
#
# $port::                          Override the port of the master we connect to.
#                                  type:integer
#
#
#
# * Advanced usage:
#
#   class {'mcollective':
#     agent_noop => true,
#     version    => '2.7.20-1',
#   }
#

class mcollective (
  $version                     = $mcollective::params::version,
  $dir                         = $mcollective::params::dir,
  $server_template             = $mcollective::params::server_template,
  $client_template             = $mcollective::params::client_template,
  $package1                    = $mcollective::params::package1,
  $package2                    = $mcollective::params::package2,
  $mco_puppet_package1         = $mcollective::params::mco_puppet_package1,
  $mco_puppet_package2         = $mcollective::params::mco_puppet_package2,
  $puppet_agent                = $mcollective::params::puppet_agent,
  $puppet_master               = $mcollective::params::puppet_master,
  $activemq_host               = $mcollective::params::activemq_host,
  $activemq_port               = $mcollective::params::activemq_port, 
  $activemq_user               = $mcollective::params::activemq_user,
  $activemq_password           = $mcollective::params::activemq_password,
  $activemq_hb_interval        = $mcollective::params::activemq_hb_interval,
  $activemq_reconn_attempts = $mcollective::params::activemq_reconn_attempts,
) inherits mcollective::params {

  validate_bool($puppet_master)

  class { 'mcollective::install': } ~>
  class { 'mcollective::config': } ->
  Class['mcollective']
}
