#!/usr/bin/sh

set -e

#rubygems
apt-get install -y rubygems

#This will speed up the gem source in CN.
gem source -r http://rubygems.org/
gem source -a http://ruby.taobao.org

# Install vagrant
gem install vagrant
gem install librarian-puppet

# Install VirtualBox. There is a probleam, if I don't use 4.2 version, the vagrant will complain.
# This is a trick.First download and install the current 4.2.2 VirtualBox
touch /etc/apt/sources.list.d/virtualbox.list
echo 'deb http://download.virtualbox.org/virtualbox/debian precise contrib' > /etc/apt/sources.list.d/virtualbox.list
apt-get update
apt-get install --force-yes virtualbox-4.2

#Download the 4.2.0-RC1 and Install
wget http://download.virtualbox.org/virtualbox/4.2.0_RC1/virtualbox-4.2_4.2.0~rc1-80014~Ubuntu~precise_amd64.deb
dpkg -i virtualbox-4.2_4.2.0~rc1-80014~Ubuntu~precise_amd64.deb
wget http://download.virtualbox.org/virtualbox/4.2.0_RC1/Oracle_VM_VirtualBox_Extension_Pack-4.2.0_RC1-80014.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.2.0_RC1-80014.vbox-extpack


#Install the openstack puppet modules
librarian-puppet install --verbose
cp -r modules /etc/puppet

echo "Pre Install Finish!"
