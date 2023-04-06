#!/bin/sh -eu

# Change root password
echo "root:$RETRO_ROOT_PASSWD" | chpasswd

# Prepare pub directory
mkdir -p /srv/pub
chmod 1777 /srv/pub

# Set user-specific Samba configuration
cat >/etc/samba/smb.conf.retroskauser <<EOF
[global]
   workgroup = $RETRO_WORKGROUP
EOF
