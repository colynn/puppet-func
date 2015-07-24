# Install the mcollective server and client installation
class mcollective::install inherits mcollective {
  
  if $mcollective::puppet_agent {
    package { [ $mcollective::package1, $mcollective::package2,$mcollective::mco_puppet_package1,$mcollective::mco_puppet_package2,mcollective-facter-facts ]:
      ensure => $mcollective::ensure,
      }
  }
  
  if $mcollective::puppet_master {
    package { [ $mcollective::package1, $mcollective::package2,$mcollective::mco_puppet_package1,$mcollective::mco_puppet_package2,mcollective-facter-facts ]:
      ensure => $mcollective::version,
      }
    }
}
