FROM ubuntu

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y python3 openssh-server

COPY init.sh /

ENTRYPOINT ["/init.sh"]
