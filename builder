# How to build: docker build -t jenciso/ansible-builder -f builder .
#

FROM alpine:3.13 as builder

# Package required tools for all flavour's "builder" stage
RUN set -eux \
	&& apk add --update --no-cache \
		bc \
		cargo \
		cmake \
		curl \
		g++ \
		gcc \
		git \
		libffi-dev \
		make \
		musl-dev \
		openssl-dev \
		py3-pip \
		python3 \
		python3-dev \
		rust


# Pip required tools for all flavour's "builder" stage
RUN set -eux \
	&& pip3 install --no-cache-dir --no-compile \
		wheel \
	&& pip3 install --no-cache-dir --no-compile \
		Jinja2 \
		MarkupSafe \
		PyNaCl \
		PyYaml \
		bcrypt \
		cffi \
		cryptography \
		pycparser
