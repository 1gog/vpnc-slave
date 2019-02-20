FROM 1gog/jre:10.0.2


MAINTAINER mirzuev.a.v@gmail.com

RUN yum install -y epel-release && yum clean all -y
RUN yum install -y vpnc vim net-tools openssh-clients.x86_64 && yum clean all -y
RUN mkdir -p /root/.ssh && chown root:root -R /root/.ssh && chgrp -R 0 /root

ENV HOME=/root
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
USER 0

WORKDIR /root




