# Install the func certmaster and minions installation
class func::install inherits func {
    package { [ python-simplejson, certmaster,func ]:
      ensure => $func::ensure,
    }
}
