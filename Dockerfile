FROM quay.io/official-images/debian:bullseye

# Install packages
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install systemd-sysv apt-utils
RUN apt-get -y install --no-install-recommends samba vsftpd ngircd inotify-tools pwgen
RUN apt-get clean

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
