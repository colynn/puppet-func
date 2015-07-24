# Set up the mcollective config
class mcollective::config {
  if $mcollective::puppet_agent {
  file { $mcollective::dir:
    ensure => directory,
  } ->
  file { "${mcollective::dir}/server.cfg":
    content => template($mcollective::server_template),
  } ~>
  class { "mcollective::service": }
  }

  if $mcollective::puppet_master {
    file { "${mcollective::dir}/client.cfg":
      content => template($mcollective::client_template),
    }
  }
}
