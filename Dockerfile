FROM quay.io/official-images/debian

# Install packages
ADD template/root/retroska/deps.sh /root/retroska/
RUN /root/retroska/deps.sh

# Add some tools for humans
RUN apt-get -y install --no-install-recommends tcpdump iproute2 less net-tools smbclient
RUN apt-get -y install --no-install-recommends nano

# Configure
COPY --chown=root:root template /
ARG RETRO_WORKGROUP=RETRO
RUN /root/retroska/conf.sh

CMD [ "/sbin/init" ]
