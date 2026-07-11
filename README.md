*This project has been created as part of the 42 curriculum by liyu-her.*

# Inception

## Description
This project focuses on system administration, virtualization, and infrastructure deployment using Docker. The goal is to set up a multi-container local environment using Docker Compose where each service runs in a dedicated container:
- **Nginx** (configured with TLSv1.2/1.3) serving as the entrypoint.
- **WordPress** (configured with PHP-FPM) to serve the dynamic content.
- **MariaDB** as the backend database for WordPress.

All services are built from the penultimate stable version of Debian (`bullseye`).

---

## Project Description & Technical Decisions

### Virtual Machines vs Docker
- **Virtual Machines (VMs)** virtualize the physical hardware. They bundle a full guest Operating System, virtual drivers, and the application. This makes them resource-heavy and slow to boot.
- **Docker Containers** virtualize the OS kernel. They share the host system's kernel and isolate process execution. Containers are extremely lightweight, boot in milliseconds, and use minimal disk space.

### Secrets vs Environment Variables
- **Environment Variables** are easily exposed (e.g. via `docker inspect` or within log files). They are suitable for non-sensitive configurations (like domain name or DB user name).
- **Docker Secrets** store confidential information (like passwords) securely. Docker mounts these secrets as read-only files under `/run/secrets/` inside the containers, preventing them from being exposed in environment listings or images.

### Docker Network vs Host Network
- **Host Network** removes isolation between the container and the Docker host. The container uses the host's networking stack directly, exposing ports directly on the host interface.
- **Docker Network (Bridge)** creates a private internal virtual network. Containers on the network can communicate with each other using container names as hostnames, but are completely isolated from the outside world unless specific ports are explicitly published.

### Docker Volumes vs Bind Mounts
- **Bind Mounts** map a file or directory on the host machine to a directory in the container. They depend on the directory structure and permissions of the host.
- **Docker Volumes** are managed by Docker. They are independent of the host directory structure. For this project, we utilize local-driver named volumes configured with specific host paths `/home/liyu-her/data/wordpress` and `/home/liyu-her/data/mariadb` to enforce storage inside the host's `/home/login/data` directory as requested.

---

## Instructions

### Prerequisites
- Docker and Docker Compose installed on the host.
- Proper permissions to run docker commands (or use `sudo`).

### Build & Run Stack
1. Clone the repository.
2. Initialize secrets:
   ```bash
   make setup
   ```
   (This creates the `secrets/` directory and fills them with default credentials if they don't exist.)
3. Start the application:
   ```bash
   make
   ```
   (This will build the Docker images and start the services.)

### Stop Stack
To stop the services:
```bash
make down
```

### Clean Up
To clean containers and networks:
```bash
make clean
```
To delete all containers, networks, volumes, and local data:
```bash
make fclean
```

---

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Specification](https://docs.docker.com/compose/)
- [NGINX SSL Termination](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [WP-CLI Command Reference](https://developer.wordpress.org/cli/commands/)
- [MariaDB Knowledge Base](https://mariadb.com/kb/en/)

### AI Usage
- **Usage**: AI was used to design the database bootstrap script, format configuration files for PHP-FPM and Nginx to ensure maximum performance and security, and format the user and developer documentation.
- **Verification**: All configurations and script commands were manually reviewed against the Debian Bullseye manuals and standard Docker practices to ensure compliance with the PDF guidelines.
