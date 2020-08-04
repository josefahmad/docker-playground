FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	git \
	vim \
	sudo \
	linux-tools-common \
	linux-tools-aws \
	mongodb \
	wget \
	gnupg


RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu

ENV HOME /home/ubuntu

RUN mkdir -p ${HOME}/data && chown ${uid}:${gid} -R /home/ubuntu/data && chmod -R 777 ${HOME}/data

WORKDIR ${HOME}

 
USER ubuntu

ENTRYPOINT ["/usr/bin/mongod", "--dbpath", "/home/ubuntu/data", "--logpath", "mongod.log"] 
#ENTRYPOINT ["/usr/bin/mongod", "--dbpath", "/home/ubuntu/data", "--logpath", "mongod.log", "--fork"] 
#CMD ["/usr/bin/mongod --dbpath ${HOME}/data --logpath ${HOME}/mongod.log --fork"]  
#CMD ["/bin/bash"]  
