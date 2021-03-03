# Set ubuntu as base image
FROM ubuntu:20.04

RUN apt update -y
# RUN apt-get -y install xauth
RUN apt install -y firefox

# Install misc tools, SSH server and configure auth as you like
RUN apt install -y vim iputils-ping

# Install Husarnet
RUN apt install -y curl gnupg2 systemd 
RUN curl https://install.husarnet.com/install.sh | bash

# Find your JOINCODE at https://app.husarnet.com
ENV JOINCODE=""
ENV HOSTNAME=my-container-1

EXPOSE 8887

# Run firefox
# CMD /usr/bin/firefox

COPY init-container.sh /opt
CMD /opt/init-container.sh

# # Install Husarnet Client
# RUN apt update -y

# RUN apt install -y curl gnupg2 systemd

# RUN curl https://install.husarnet.com/install.sh | bash

# RUN update-alternatives --set ip6tables /usr/sbin/ip6tables-nft

# # Find your JOINCODE at https://app.husarnet.com
# ENV JOINCODE=""
# ENV HOSTNAME=docker-chrome-vpn
# ENV 

