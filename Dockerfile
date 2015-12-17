FROM alpine:latest
RUN apk upgrade --update && apk add openssh && \
  echo "ForceCommand echo 'MANAGEMENT CHANNEL, general usage prohibited!'" >> /etc/ssh/sshd_config && \ 
  [ -e /etc/ssh/ssh_host_rsa_key ] && true || ssh-keygen -A && \
  mkdir -p ~/.ssh && \
  chmod 700 ~/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
COPY host_keys/* /etc/ssh/
RUN chown root:root -R /root/.ssh /etc/ssh && \
    chmod 700 /root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd","-De","-f","/etc/ssh/sshd_config"]
