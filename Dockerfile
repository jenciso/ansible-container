FROM ubuntu:20.04                                                     
                                                                      
ENV DEBIAN_FRONTEND=noninteractive                                    
                                                                      
RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install ansible && rm -rf /var/cache/apt
