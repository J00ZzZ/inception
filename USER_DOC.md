# USER DOC

## Service 
1. **NIGNX**: The reverse proxy and secure entrypoint. Terminates SSL/TLS on port 443
Server Static files.

2. **WordPress** PHP script logic and Wordpress pages

3. **MariaDB** Store WP site content, users and metadata.

## Start the project 

`make` to run

`make down` to pause

`make fclean` to terminate

## Access

### Setup 
configure domain `liyu-her.42.kl` to point to local machine:

VIM to `/etc/hosts` 
- add `127.0.0.1 liyu-her.42.kl` to `/etc/hosts` 

 Open Browser and go to 
 `https://liyu-her.42.kl`

cat from secrets to get password. 

## Checking

### Check active containers
```bash
docker compose -f srcs/docker-compose.yml ps
```

### Check Logs:
```bash
docker compose -f srcs/docker-compose.yml logs -f
```

### Check networks and ports
```bash
docker ps
```

port : 443