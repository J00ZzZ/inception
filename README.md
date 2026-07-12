# Inception

## Description
This project focuses on system administration, virtualization, and infrastructure deployment using Docker. The goal is to set up a multi-container local environment using Docker Compose where each service runs in a dedicated container:
- **Nginx** (configured with TLSv1.2/1.3) serving as the entrypoint.
- **WordPress** (configured with PHP-FPM) to serve the dynamic content.
- **MariaDB** as the backend database for WordPress.

Debian was used to built all of the services.

---

## Project Description

The **Inception** project introduces the fundamentals of **DevOps**, **system administration**, and **containerization** by requiring students to build a complete web infrastructure using Docker. Rather than focusing on application development, the project emphasizes designing a secure, scalable, and reproducible deployment environment where each service runs independently inside its own container.

Students must create custom Docker images and orchestrate them using **Docker Compose**. The mandatory infrastructure consists of an **NGINX** web server configured with TLS, a **WordPress** application running on PHP-FPM, and a **MariaDB** database. These services communicate through a dedicated Docker network while storing persistent data using Docker volumes to ensure data survives container restarts.

The project also teaches essential Linux administration skills, including environment variable management, service initialization, file permissions, networking, and container security. Students learn how to automate deployment, configure reverse proxies, troubleshoot connectivity issues, and maintain isolated services that work together reliably.

The bonus section extends the infrastructure by integrating additional services such as **Redis**, **FTP**, **Adminer**, or a static website, demonstrating how containerized applications can be expanded without affecting the existing architecture.

Overall, Inception provides practical experience in deploying production-like environments and establishes a strong foundation in Docker, infrastructure management, networking, and modern software deployment practices.

---

## Instructions

### BEFORE RUNNING THE PROJECT
- Docker and Docker Compose installed on the host. (important)
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