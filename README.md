# Ansible Docker

## Intro

Repositorio que cria uma docker image para rodar ansible como container

## Getting Started

## Build

```shell
docker build -t jenciso/ansible-builder  -f builder .
docker build -t jenciso/ansible-container:alpine --build-arg=VERSION=2.10 .
```

## Run

```shell
docker run --rm -it jenciso/ansible-container:alpine ansible --version
```

## Author

[Juan Enciso](mailto:juan.enciso@gmail.com)
