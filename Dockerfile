FROM java:8-jdk
MAINTAINER nqntan

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/run/sshd && \
    rm /etc/ssh/ssh_host_*key*
COPY sshd_config /etc/ssh/sshd_config
ADD start-app /

WORKDIR /
ADD sampledocker-1.0-SNAPSHOT.tar.gz /pm
#WORKDIR pm/sampledocker-1.0-SNAPSHOT
RUN chmod 755 pm/sampledocker-1.0-SNAPSHOT/bin/*
RUN chmod 755 /start-app

EXPOSE 1099 8101 44444 22
ENTRYPOINT ["/start-app"]
