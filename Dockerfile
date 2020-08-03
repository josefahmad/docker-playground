FROM ubuntu:18.04

ARG DRIVER_VERSION=3.12.2

RUN apt-get update && apt-get install -y \
	git \
	nano \
	sudo \
	linux-tools-common \
	    linux-tools-5.3.0-1030-aws \
    default-jdk \
    maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu

ENV HOME /home/ubuntu

WORKDIR ${HOME}

USER ubuntu

CMD ["/bin/bash"]  
