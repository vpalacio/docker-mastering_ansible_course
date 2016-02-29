clone the repo:
* git clone git@github.com:vpalacio/docker-mastering_ansible_course.git
* cd docker-mastering_ansible_course

build the Dockerfile:
* docker build --rm=true -t udemy_mastering-ansible .

build containers for worker nodes:
* docker run -d -P --cap-add=all `--hostname=<worker_name>` `--name <worker_name>` --privileged udemy_mastering-ansible

for the ansible control node, generate ssh key
* docker run -d -P --cap-add=all `--hostname=control` `--name control` --privileged udemy_mastering-ansible
* docker exec -it control /bin/bash
* ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa

copy the key to worker nodes:
* `ssh-copy-id <worker-name>`

make sure you have ssh access:
* `ssh <worker_name>`   
