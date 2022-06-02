#!/bin/bash

mkdir /run/sshd
mkdir ~/.ssh

echo "$SSH_KEY" > ~/.ssh/authorized_keys

/usr/sbin/sshd

exec python3 -m http.server 8080
