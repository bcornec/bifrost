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
RUN useradd -m bruno
RUN chown -R bruno /usr/local
RUN echo "bruno   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY launch-bifrost.sh /home/bruno/launch-bifrost.sh
COPY setup-env.sh /home/bruno/setup-env.sh
RUN chmod 755 /home/bruno/launch-bifrost.sh /home/bruno/setup-env.sh
ENV BIFROST_DOCKER YES
RUN su - bruno -c ./launch-bifrost.sh
CMD /bin/bash
