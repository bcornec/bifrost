# This Dockerfile is to build a container
# in order to run a standalone Ironic with bifrost
FROM ubuntu:15.04
MAINTAINER bruno.cornec@hp.com
ENV DEBIAN_FRONTEND noninterative
ENV http_proxy http://web-proxy.fra.hp.com:8080
ENV https_proxy http://web-proxy.fra.hp.com:8080
RUN apt-get update
RUN apt-get -y install python-mock git openssh-client libpython2.7-dev python-oslotest 
# Optional
RUN apt-get update
RUN apt-get -y install python-pip bash sed sudo
RUN apt-get -y install vim-runtime strace
RUN apt-get -y install libyaml-cpp-dev
ENV BIFROST_UID bruno
RUN useradd -m $BIFROST_UID
RUN chown -R $BIFROST_UID /usr/local
RUN echo "$BIFROST_UID   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY launch-bifrost.sh /home/$BIFROST_UID/launch-bifrost.sh
RUN chmod 755 /home/$BIFROST_UID/launch-bifrost.sh
RUN su - $BIFROST_UID -c "./launch-bifrost.sh $http_proxy $https_proxy"
CMD /bin/bash
