FROM quay.io/official-images/debian:bullseye

# Ensure we have all necessary apt configs
COPY --chown=root:root template/etc/apt /etc/apt

# Install packages
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install systemd-sysv apt-utils
RUN apt-get -y install --no-install-recommends samba vsftpd ngircd inotify-tools pwgen yq
RUN apt-get clean

# Enable some services
RUN systemctl enable systemd-networkd

# Not strictly needed but helps debugging
RUN apt-get -y install --no-install-recommends tcpdump iproute2 net-tools smbclient
RUN apt-get -y install --no-install-recommends nano less
RUN apt-get -y install --no-install-recommends ncftp
RUN apt-get -y install --no-install-recommends irssi

# Volume for public shares and other permanent storage
VOLUME "/mnt"

# Configure
COPY --chown=root:root template /

# Run-time configuration is done by template/etc/systemd/system-generators/retroska-initial

CMD [ "/sbin/init" ]
