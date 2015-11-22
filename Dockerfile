FROM ubuntu:15.10
# FROM ubuntu:14.04.3

MAINTAINER John Lin <linton.tw@gmail.com>

# Dev Tool
RUN apt-get update && \
    apt-get install -qy --no-install-recommends git vim unzip wget curl tcpdump openssh-server

# Python
RUN apt-get install -qy --no-install-recommends python-setuptools python-pip && \
      pip install -U pip ipython

# SSH configure
RUN mkdir /var/run/sshd

RUN echo 'root:ec2@hsnl' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD    ["/usr/sbin/sshd", "-D"]
