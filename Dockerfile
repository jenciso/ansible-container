# --------------------------------------------------------------------------------------------------
# Builder Image
# --------------------------------------------------------------------------------------------------
# See ./builder for this image
FROM jenciso/ansible-builder as builder

ARG VERSION
RUN set -eux \
	&& if [ "${VERSION}" = "latest" ]; then \
		pip3 install --no-cache-dir --no-compile ansible; \
	elif [ "${VERSION}" = "2.9" ]; then \
		pip3 install --no-cache-dir --no-compile "ansible>=${VERSION},<2.10"; \
	elif [ "${VERSION}" = "2.10" ]; then \
		pip3 install --no-cache-dir --no-compile "ansible>=${VERSION},<2.11"; \
	else \
		pip3 install --no-cache-dir --no-compile "ansible>=${VERSION},<$(echo "${VERSION}+0.1" | bc)"; \
	fi \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

# Python packages (copied to final image)
RUN set -eux \
	&& apk add --no-cache  \
	&& pip3 install --no-cache-dir --no-compile \
		paramiko \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

# Clean-up some site-packages to safe space
RUN set -eux \
	&& pip3 uninstall --yes \
		setuptools \
		wheel


# --------------------------------------------------------------------------------------------------
# Final Image
# --------------------------------------------------------------------------------------------------
FROM alpine:3.13 as production
ARG VERSION

RUN set -eux \
	&& apk add --no-cache \
		py3-pip \
		python3 \
	&& ln -sf /usr/bin/python3 /usr/bin/python \
	&& ln -sf ansible /usr/bin/ansible-config \
	&& ln -sf ansible /usr/bin/ansible-console \
	&& ln -sf ansible /usr/bin/ansible-doc \
	&& ln -sf ansible /usr/bin/ansible-galaxy \
	&& ln -sf ansible /usr/bin/ansible-inventory \
	&& ln -sf ansible /usr/bin/ansible-playbook \
	&& ln -sf ansible /usr/bin/ansible-pull \
	&& ln -sf ansible /usr/bin/ansible-test \
	&& ln -sf ansible /usr/bin/ansible-vault \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

COPY --from=builder /usr/lib/python3.8/site-packages/ /usr/lib/python3.8/site-packages/
COPY --from=builder /usr/bin/ansible /usr/bin/ansible
COPY --from=builder /usr/bin/ansible-connection /usr/bin/ansible-connection

WORKDIR /data
CMD ["/bin/sh"]
