#!/bin/sh -eu

# Install the packages we need
apt-get update
apt-get -y install systemd-sysv
apt-get -y install --no-install-recommeds samba vsftpd tcpdump iproute2 ngircd
apt-get clean
