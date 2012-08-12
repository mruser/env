echo 'first, select the latest version of ruby'
sudo update-alternatives --config ruby

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


# apparently debian doesnt come with lastlog set up
touch /var/log/lastlog
chgrp adm /var/log/lastlog
chmod 664 /var/log/lastlog
