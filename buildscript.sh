adduser chris
adduser chris www-data
adduser chris adm
adduser chris sudo

echo 'update hostname'
edit /etc/hostname
hostname -F /etc/hostname

echo '/etc/sysctl.conf, uncomment kernel.printk = 3 4 1 3'
edit /etc/sysctl.conf

gem install wirble

echo 'select TZ'
dpkg-reconfigure tzdata

# seriously ruby, what the fuck.
gem install bins/ruby-debug-base19-0.11.26.gem -- --with-ruby-include=/usr/include/ruby-1.9.1/ruby-1.9.3-p0/
gem install bins/linecache19-0.5.13.gem -- --with-ruby-include=/usr/include/ruby-1.9.1/ruby-1.9.3-p0/

git clone git://github.com/vim-ruby/vim-ruby.git
cd vim-ruby
bin/vim-ruby-install.rb
cd -
rm -rf vim-ruby

apt-get remove exim4-base
apt-get install postfix
apt-get autoremove
dpkg --audit

# apparently debian doesnt come with lastlog set up
touch /var/log/lastlog
chgrp adm /var/log/lastlog
chmod 664 /var/log/lastlog
