# This Dockerfile is to build a container
# in order to run a standalone Ironic with bifrost
FROM ubuntu:14.04
MAINTAINER bruno.cornec@hp.com
# To be launched with docker build . in the dir containing this file
ENV DEBIAN_FRONTEND noninterative
# In case of proxy usage
ENV http_proxy http://web-proxy.fra.hp.com:8080
ENV https_proxy http://web-proxy.fra.hp.com:8080
RUN apt-get update
RUN apt-get -y install python-mock git openssh-client libpython2.7-dev libexpat1-dev python-oslotest libyaml-dev python-pip libyaml-cpp-dev
# Optional
RUN apt-get -y install vim-runtime strace
# Configure a sngle use to launch operations
ENV BIFROST_UID bruno
RUN useradd -m $BIFROST_UID
RUN chown -R $BIFROST_UID /usr/local
# Configure sudo for bifrost
RUN echo "$BIFROST_UID   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# In case of proxy usage
RUN echo 'Defaults    env_keep += "no_proxy http_proxy https_proxy ftp_proxy"' >> /etc/sudoers
COPY launch-bifrost.sh /home/$BIFROST_UID/launch-bifrost.sh
RUN chmod 755 /home/$BIFROST_UID/launch-bifrost.sh
# Kudos to https://github.com/docker/docker/issues/10324 to have the 
# possibility to modify /etc/hosts
RUN echo "127.0.0.1 $HOSTNAME localhost" >> /etc/hosts ; su - $BIFROST_UID -c "./launch-bifrost.sh $http_proxy $https_proxy"
CMD /bin/bash
