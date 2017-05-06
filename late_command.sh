#!/bin/bash
cat>/etc/apt/sources.list<<EOF
deb http://mirrors.163.com/debian/ testing main non-free contrib
deb http://mirrors.163.com/debian/ testing-updates main non-free contrib
deb-src http://mirrors.163.com/debian/ testing main non-free contrib
deb-src http://mirrors.163.com/debian/ testing-updates main non-free contrib
deb http://mirrors.163.com/debian-security/ testing/updates main non-free contrib
deb-src http://mirrors.163.com/debian-security/ testing/updates main non-free contrib
EOF

# passwordless sudo
echo "%sudo   ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# public ssh key for vagrant user
# mkdir /home/vagrant/.ssh
# wget -O /home/vagrant/.ssh/authorized_keys "file:///home/zql/.ssh/id_rsa.pub"
# chmod 755 /home/vagrant/.ssh
# chmod 644 /home/vagrant/.ssh/authorized_keys
# chown -R vagrant:vagrant /home/vagrant/.ssh

# speed up ssh
# echo "UseDNS no" >> /etc/ssh/sshd_config

# Install chef from omnibus
# curl -L https://www.getchef.com/chef/install.sh | bash

# display grub timeout and login promt after boot
sed -i \
  -e "s/quiet splash//" \
  -e "s/GRUB_TIMEOUT=[0-9]/GRUB_TIMEOUT=0/" \
  /etc/default/grub
update-grub

# upgrade && clean up
apt-get update
apt-get upgrade -y
apt-get clean

# Zero free space to aid VM compression
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
