FROM centos:centos7

RUN yum -y install epel-release && \
    yum -y install PyYAML python-jinja2 python-httplib2 \
      python-keyczar python-paramiko python-setuptools \
      git python-pip ansible
    
RUN yum clean all && rm -rf /var/cache/yum

RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts

CMD ['ansible']
