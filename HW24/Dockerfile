FROM ubuntu:18.04

RUN apt-get update && \
apt-get install -y software-properties-common &&\
add-apt-repository --yes -u ppa:ansible/ansible &&\
apt-get install -y ansible

RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
COPY . /etc/ansible/

