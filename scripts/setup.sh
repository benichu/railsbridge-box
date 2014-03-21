#!/bin/bash

set -e

echo "Installing for Railsbridge-MTL"

# Install vagrant keys
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 ~/.ssh/authorized_keys
chown -R vagrant ~/.ssh

# Railsbridge MOTD
sudo apt-get install update-motd
sudo rm /etc/update-motd.d/*

sudo sh -c "cat > /etc/update-motd.d/10-railsbridge << 'EOT'
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

EOT"

sudo chmod +x /etc/update-motd.d/10-railsbridge
# Force message
sudo run-parts /etc/update-motd.d/

# Install rbenv and Ruby
rm -rf /home/vagrant/.rbenv
git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
rbenv install 2.1.1 && rbenv global 2.1.1

# get Rails running
cd /vagrant
echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc
gem install bundler
gem install rails

#
