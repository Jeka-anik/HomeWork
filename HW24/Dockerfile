FROM ansible/ubuntu14.04-ansible:stable

COPY hosts /home/
RUN ssh-keygen -y
RUN ssh-copy-id root@192.168.100.40 && ssh-copy-id root@192.168.100.41
CMD ansible -m ping all -i /home/hosts