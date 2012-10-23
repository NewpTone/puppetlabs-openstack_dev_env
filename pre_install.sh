#!/usr/bin/sh

set -e

#rubygems
apt-get install -y rubygems

gem source -r http://rubygems.org/
gem source -a http://ruby.taobao.org

gem install vagrant
gem install librarian-puppet

#VirtualBox

wget http://download.virtualbox.org/virtualbox/4.2.0_RC1/virtualbox-4.2_4.2.0~rc1-80014~Ubuntu~precise_amd64.deb
dpkg -i virtualbox-4.2_4.2.0~rc1-80014~Ubuntu~precise_amd64.deb

wget http://download.virtualbox.org/virtualbox/4.2.0_RC1/Oracle_VM_VirtualBox_Extension_Pack-4.2.0_RC1-80014.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.2.0_RC1-80014.vbox-extpack


librarian-puppet install 

cp -r modules /etc/puppet
