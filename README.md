

Github repo for building docker containers to use in the Mastering Ansible Course. 

Disclaimer:
----------
This is a personal repo and contents here are strictly for testing purposes for following along in the Mastering Ansible class. There is no relationship between the author/teacher of the class. Please use at your own discretion.   

The containers are built to permit root login via ssh to the worker nodes. This is not best practice and is only used here to facilitate practice linux containers to use alongside the class. One should consider changing the password in the Dockerfile.

How to use:
-----------

clone the repo:
```
git clone git@github.com:vpalacio/docker-mastering_ansible_course.git
cd docker-mastering_ansible_course
```

change the ssh password to something other than password in the Dockerfile.
```
# Consider changing the password here:
RUN echo 'root:password' | chpasswd
```

build the Dockerfile and give it a tag of our own:
```
docker build --rm -t udemy_mastering-ansible .
```

build containers for worker nodes:
```
docker run -d -P --cap-add=all --hostname=<worker_name> --name <github_handle>_<worker_name> --privileged udemy_mastering-ansible

# As an example:
docker run -d -P --cap-add=all --hostname=control --name vpalacio_control --privileged udemy_mastering-ansible
docker run -d -P --cap-add=all --hostname=app01 --name vpalacio_app01 --privileged udemy_mastering-ansible

```

you have to make sure that the worker nodes are known to the control node via DNS. 
Update your control node's /etc/hosts file to have the IP addresses of your worker nodes. 
```
# You can find the IP addresses of your worker nodes by using `docker inspect` on the coreOS host
$ docker inspect vpalacio_app01

# Log into the control node:
docker exec -it vpalacio_control /bin/bash

# And edit it's /etc/hosts file with the IP/hostname of your worker nodes:
   $ vi /etc/hosts

```

for the ansible control node, generate a ssh key and publish it to your worker nodes.
```
# log into control node:
docker exec -it vpalacio_control /bin/bash
   # generate key
   $ ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa

   # From within the control node, copy the key to the worker nodes: 
   ssh-copy-id <worker_name>
      $ ssh-copy-id app01

   # make sure you have ssh access without being prompt:
   ssh <workern_name>
      $ ssh app01
```   
