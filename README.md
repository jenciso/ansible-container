# Ansible Docker

## Intro

Repositorio que cria uma docker image para rodar ansible como container

## Getting Started

* Build


```shell
docker build -t jenciso/ansible-builder  -f builder .
docker build -t jenciso/ansible-container:2.10-alpine --build-arg=VERSION=2.10 .
```

* Push

```shell
docker push jenciso/ansible-container:2.10-alpine
```

* Run

```shell
docker run --rm -v $(pwd):/data jenciso/ansible-container ansible-playbook playbook.yml
```

## Maintenance

Author:

* [Juan Enciso](mailto:juan.enciso@gmail.com)

References:

* https://github.com/cytopia/docker-ansible
* https://www.toptechskills.com/ansible-tutorials-courses/speed-up-ansible-playbooks-pipelining-mitogen/
