# Developer Documentation

## Setup

OS: Debian 13
Package: docker.io, docker-compose-plugin

The `Makefile`, `secrets/` are in the Root directory

`srcs/`
- holds the `.env` file and `docker-compose.yml`

`srcs/requirements/<service>/`
- `Dockerfile` , `conf/` , `tools/`

---

## Build and Launch
 - Run Make
 - access wordpress page using https://liyu-her.42.kl/

## Useful Command 

To list the Volumes `docker volume ls`

## Where the project are stored

- Location on VM host:
 ```bash
/home/vboxuser/42/inception/mariadb
- Stores database log.
/home/vboxuser/42/inception/wordpress
- Stores WordPress src files.
 ```