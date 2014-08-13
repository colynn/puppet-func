#puppet-func
mailto：colynn.liu@gmail.com
author: colynn.liu  

===========
#Describe

puppet module  install func master, minion.

#Installation
#Using GIT
git clone git://github.com/colynn/puppet-func.git

#example
Install func minion:
    $func::params::func_minion = true
    
or install  func certmaster:
    $func::params::func_minion = false
