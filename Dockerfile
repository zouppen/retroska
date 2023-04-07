FROM quay.io/official-images/debian

# Install packages
ADD template/root/retroska/deps.sh /root/retroska/
RUN /root/retroska/deps.sh

# Add some tools for humans
RUN apt-get -y install --no-install-recommends tcpdump iproute2 less net-tools smbclient
RUN apt-get -y install --no-install-recommends nano
RUN apt-get -y install --no-install-recommends ncftp

# Volume for public shares and other permanent storage
VOLUME "/mnt"

# Configure
COPY --chown=root:root template /

# Run-time configuration is done by template/etc/systemd/system-generators/retroska-initial

CMD [ "/sbin/init" ]
