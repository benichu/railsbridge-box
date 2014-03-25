#!/bin/bash

set -e

echo "Installing for Railsbridge-MTL"

# Required Libs
apt-get -y -q install curl wget git-core vim
apt-get -y -q install build-essential openssl \
                      gawk libreadline6-dev zlib1g zlib1g-dev \
                      libssl-dev libyaml-dev libsqlite3-dev \
                      sqlite3 autoconf libgdbm-dev libncurses5-dev \
                      automake libtool bison pkg-config libffi-dev \
                      libxml2-dev libxslt-dev libxml2 libmagick++-dev

# Railsbridge MOTD
apt-get -y -q install update-motd
rm /etc/update-motd.d/*

sh -c "cat > /etc/update-motd.d/10-railsbridge << 'EOT'
#!/bin/sh

echo '   ========================================'
echo '    ____      _     ___  _      ____'
echo '   |  _ \    / \   |_ _|| |    / ___|'
echo '   | |_) |  / _ \   | | | |    \___ \'
echo '   |  _ <  / ___ \  | | | |___  ___) |'
echo '   |_|_\_\/_/__ \_\|___||_____||____/_____'
echo '   | __ ) |  _ \ |_ _||  _ \  / ___|| ____|'
echo '   |  _ \ | |_) | | | | | | || |  _ |  _|'
echo '   | |_) ||  _ <  | | | |_| || |_| || |___'
echo '   |____/ |_| \_\|___||____/  \____||_____|'
echo ''
echo '   ========================================'
echo ''
echo '   Welcome to the Railsbridge Montreal virtual machine!  The RailsBridge VM is a *computer within your computer*'
echo '   running the Linux operating system.  Everything you need is installed, including:'
echo '   Ruby 2.1, Rails 4.0, sqlite3, the heroku toolbelt, and git.'
echo ''
echo '   When you start your Rails app, visit http://localhost:3000 in your web browser.
echo ''
echo '   The ~/workspace directory is shared with the folder on your laptop where you created this VM.  Any file you'
echo '   put there in your laptop will appear here in ~/workspace.  This lets you edit files with an OSX or Windows'
echo '   text editor, and run them here in the VM.'
echo ''
echo '   To leave the virtual machine, type'
echo '       exit'
echo '   and hit return. '
echo ''
echo '   ========================================'

EOT"

chmod +x /etc/update-motd.d/10-railsbridge
# Force message
run-parts /etc/update-motd.d/

# Install rbenv and Ruby
rm -rf /home/vagrant/.rbenv
git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc
git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

chown -R vagrant:vagrant /home/vagrant

source /home/vagrant/.bashrc || true
/home/vagrant/.rbenv/bin/rbenv install 2.1.1
/home/vagrant/.rbenv/bin/rbenv rehash
/home/vagrant/.rbenv/bin/rbenv global 2.1.1

# get Rails running
echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc
gem install bundler || true
gem install rails || true

# Heroku Toolbelt is a .deb package, so install as root.
# curl -L https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Our bash setup will cd to workspace on login.
# cd /home/vagrant
# ln -s /vagrant workspace
