puppet-func
author: colynn.liu
mail to: colynn.liu@gamil.com
===========
Describe

puppet module  install func master, minion.

Installation
Using GIT
git clone git://github.com/colynn/puppet-func.git

Install func minion:
    $func::params::func_minion = true
    
or install  func certmaster:
    $func::params::func_minion = false
