# Docker image

This image installs openssh server and python. On initialization, it starts the ssh server and serves a simple http file server on port 8080.

## Building

`docker build -t omarelawady/ubuntu-ssh .`

## Pushing

`docker push omarelawady/ubuntu-ssh`

## Running locally

`docker run --rm --name http-server -ti -e SSH_KEY="$(cat ~/.ssh/id_rsa.pub)" omarelawady/ubuntu-ssh`

To get the ip: `docker inspect http-server`, the http server can be accessed then through http://ip:8080, and ssh works over `ssh root@ip`.

