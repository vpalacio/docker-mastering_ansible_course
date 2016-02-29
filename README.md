Github repo for building docker containers to use in the Mastering Ansible Course. 

This is a personal repo and contents here are strictly for testing purposes for following along in the Mastering Ansible class. There is no relationship between the author/teacher of tthe class. Please use at your own discretion.   


clone the repo:
```
git clone git@github.com:vpalacio/docker-mastering_ansible_course.git
cd docker-mastering_ansible_course
```

build the Dockerfile:
```
docker build --rm -t udemy_mastering-ansible .
```

build containers for worker nodes:
```
docker run -d -P --cap-add=all --hostname=<worker_name> --name <github_handle>_<worker_name> --privileged udemy_mastering-ansible
```

for the ansible control node, generate ssh key
```
docker run -d -P --cap-add=all --hostname=control --name control --privileged udemy_mastering-ansible
docker exec -it control /bin/bash
ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa

# From within the control node, copy the key to the worker nodes: 
ssh-copy-id <worker-name>

# make sure you have ssh access without being prompt:
ssh <worker_name>
```   
