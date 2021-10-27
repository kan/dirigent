FROM ubuntu:20.04

RUN apt-get update && apt-get install -y openssh-server sudo
RUN mkdir /run/sshd
RUN useradd -m -s /bin/bash ubuntu && gpasswd -a ubuntu sudo
RUN echo 'ubuntu:ubuntu' | chpasswd

COPY --chown=ubuntu:ubuntu authorized_keys /home/ubuntu/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]