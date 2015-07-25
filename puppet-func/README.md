#puppet-func

author: colynn.liu  
mailto：colynn.liu@gmail.com

===========
#Describe

puppet module  install func master, minion.

#example
Install func minion:
    $func::params::func_minion = true
    
or install  func certmaster:
    $func::params::func_minion = false
