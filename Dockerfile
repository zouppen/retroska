FROM quay.io/official-images/debian

# Install packages
ADD bootstrap/deps.sh /
RUN /deps.sh

# Configure
ADD bootstrap/conf.sh /
ARG RETRO_ROOT_PASSWD=retr9
RUN /conf.sh

CMD [ "/sbin/init" ]
