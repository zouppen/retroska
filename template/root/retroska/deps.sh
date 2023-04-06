#!/bin/sh -eu

# Install the packages which are required for an operational system
apt-get update
apt-get -y upgrade
apt-get -y install systemd-sysv
apt-get -y install --no-install-recommends samba vsftpd ngircd
apt-get clean
