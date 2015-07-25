#! /bin/bash
#
echo "installing... please wait..."
###install compile environment
yum install  gcc-c++  openssl-devel  -y  1>/dev/null
yum install ruby-augeas augeas-libs  ruby-libs  -y  1>/dev/null

###download source packages
wget --no-check-certificate -O /opt/puppet-2.7.25.tar.gz  https://raw.githubusercontent.com/colynn/puppet-manage/master/install/package/puppet-2.7.25.tar.gz  1>/dev/null  2>/dev/null
wget --no-check-certificate -O /opt/facter-1.7.5.tar.gz   https://raw.githubusercontent.com/colynn/puppet-manage/master/install/package/facter-1.7.5.tar.gz  1> /dev/null 2>/dev/null
wget --no-check-certificate -O /opt/ruby-1.8.7-p374.tar.gz https://raw.githubusercontent.com/colynn/puppet-manage/master/install/package/ruby-1.8.7-p374.tar.gz 1> /dev/null 2>/dev/null


###comile install ruby
tar -zxf /opt/ruby-1.8.7-p374.tar.gz  -C  /opt
cd  /opt/ruby-1.8.7-p374
./configure  --prefix=/usr/local/ruby   1>/dev/null
make 1>/dev/null 2>/dev/null && make install 1>/dev/null 2>/dev/null  && make clean 1>/dev/null
[ -x /usr/local/ruby/bin/ruby ]  && echo -e "ruby install is \033[32mDone\033[0m"

###initialize ruby environment
ln -s  /usr/local/ruby/bin/ruby  /usr/bin
##support augeas type
RELEASE=`uname -i`
case  "$RELEASE" in
		i386)
		ln -s  /usr/lib/site_ruby/1.8/i386-linux-gnu/_augeas.so   /usr/local/ruby/lib/ruby/site_ruby/1.8/i686-linux
		ln -s  /usr/lib/site_ruby/1.8/augeas.rb /usr/local/ruby/lib/ruby/site_ruby/1.8
		;;
		x86_64)
		ln  -s  /usr/lib64/site_ruby/1.8/x86_64-linux-gnu/_augeas.so  /usr/local/ruby/lib/ruby/site_ruby/1.8/x86_64-linux/
		ln -s  /usr/lib64/site_ruby/1.8/augeas.rb   /usr/local/ruby/lib/ruby/site_ruby/1.8/
		;;
		*)
		 echo "unknown platform."
     exit 1
     ;;
esac
		

echo "MANPATH /usr/local/ruby/share/man/"  >> /etc/man.config
echo "export PATH=/usr/local/ruby/bin:\$PATH" >> /etc/profile
source /etc/profile

ruby --version  |grep 1.8.7  1>/dev/null
if [ $? = 0 ] 
then
   echo -e "ruby environment is \033[32mDone\033[0m"
else
   echo -e "ruby environment is \033[31mFailed\033[0m"
   exit 1
fi

##comile install facter
tar -zxf  /opt/facter-1.7.5.tar.gz  -C  /opt/
cd  /opt/facter-1.7.5
ruby  install.rb  1>/dev/null 2>/dev/null
[ -x /usr/local/ruby/bin/facter ] && echo -e "facter install is \033[32mDone\033[0m"

##comile install puppet
useradd puppet -s /sbin/nologin   -d /var/lib/puppet/

tar -zxf  /opt/puppet-2.7.25.tar.gz  -C  /opt/
cd  /opt/puppet-2.7.25
ruby install.rb  1>/dev/null 2>/dev/null
[ -x /usr/local/ruby/bin/puppet ] && echo -e "puppet install is \033[32mDone\033[0m"

##initialize puppet-agent
sleep 1
cd  /opt/puppet-2.7.25
cp  conf/redhat/puppet.conf   /etc/puppet/
sed -i "s/ssldir.*/ssldir = \$confdir\/ssl/"  /etc/puppet/puppet.conf
cp conf/redhat/fileserver.conf  /etc/puppet/
cp conf/redhat/client.sysconfig  /etc/sysconfig/puppet

cp conf/redhat/client.init   /etc/init.d/puppet

cp sbin/puppetd   /usr/sbin/
ln -s /usr/local/ruby/bin/puppet /usr/bin/puppet
sed -i  "s|#!/usr/bin/env.*|#!/usr/local/ruby/bin/ruby|"  /usr/sbin/puppetd

##cut-puppet-log
wget --http-user=server --http-password=server_pass -O  /etc/logrotate.d/puppet  http://y.pook.com:65165/web_install/puppet/cut_puppet_log  1>/dev/null  2>/dev/null

grep  "/usr/local/ruby/bin/ruby" /usr/sbin/puppetd  1>/dev/null

if [ $? = 0 ]
then
    echo -e "puppet-agent init is \033[32mDone\033[0m"
else
    echo -e "puppet-agent init is \033[31mFailed\033[0m"
fi

##puppet-service-crontol
chmod 755 /usr/sbin/puppetd 
chmod +x  /etc/init.d/puppet

chkconfig --add puppet
chkconfig puppet --level 35 on

chkconfig --list |grep puppet   1> /dev/null 
if [ $? = 0 ] 
then
   echo -e "puppet-agent service-control is \033[32mDone\033[0m"
else
   echo -e "puppet-agent service-control is \033[31mFailed\033[0m"
   exit 1
fi

#puppet agent  --server puppetmaster.pook.com.cn  -t
##done
