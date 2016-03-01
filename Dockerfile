FROM ubuntu:latest

MAINTAINER Victor Palacio <vpalacio@gmail.com>

# https://docs.ansible.com/ansible/intro_installation.html
# https://docs.ansible.com/ansible/intro_installation.html#latest-releases-via-apt-ubuntu

RUN apt-get install -y software-properties-common && \ 
    apt-add-repository ppa:ansible/ansible -y && \ 
    apt-get update && apt-get install -y \
    ansible \
    vim \
    openssh-server

# Ansible uses ssh. 
# https://docs.docker.com/engine/examples/running_ssh_service/
RUN mkdir /var/run/sshd

# You can change the default password here to something else. 
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
