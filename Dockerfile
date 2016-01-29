# docker container for jenkins
# openjdk-7-jre +jenkins + plugins
#
FROM java:openjdk-7-jre
MAINTAINER papaleo lee <papaleo@qq.com>

# Grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	wget git curl git-core vim-tiny openssh-client \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# Need SSH agent, for automated remote work
RUN mkdir /var/run/sshd && \
        echo " ForwardAgent yes" >> /etc/ssh/ssh_config && \
        echo " IdentityFile /var/lib/jenkins/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
        echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config




