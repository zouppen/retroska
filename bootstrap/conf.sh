#!/bin/sh -eu

# Change root password
echo "root:$RETRO_ROOT_PASSWD" | chpasswd
