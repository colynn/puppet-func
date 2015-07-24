# Set up the mcollective client as a service
class mcollective::service {
  service {'mcollective':
    name      => $mcollective::params::service_name,
    #enable => true,
    #ensure => running,
    enable => false,
    ensure => stopped,
    hasstatus => true,
    require   => Class['mcollective::install']
  }
}
