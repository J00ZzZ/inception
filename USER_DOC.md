# User Documentation

This guide describes how to manage and interact with the Inception project stack.

## 1. Services Provided
The stack provides three key services:
1. **NGINX**: Acts as the reverse proxy and secure entrypoint. It terminates SSL/TLS (v1.2 or v1.3 only) on port 443 and serves static files.
2. **WordPress (PHP-FPM)**: Executes PHP script logic and generates WordPress web pages.
3. **MariaDB**: The relational database management system that stores WordPress site contents, users, and metadata.

---

## 2. Start and Stop the Project

### To Start the Project:
From the root of the repository, execute:
```bash
make
```
This command runs the `setup` routine to create host directories and placeholder secrets, builds the custom images, and starts the containers in detached mode.

### To Stop the Project:
To pause the containers without deleting volumes:
```bash
make down
```

---

## 3. Access the Website and Administration Panel

### Host Setup
Before accessing the site, configure the domain `liyu-her.42.fr` to point to your local machine:
1. Open `/etc/hosts` in your editor with root privileges:
   ```bash
   sudo nano /etc/hosts
   ```
2. Add the following entry:
   ```text
   127.0.0.1 liyu-her.42.fr
   ```
3. Save and close.

### Accessing the Site
- **WordPress Front-end**: Open your browser and navigate to `https://liyu-her.42.fr`
- **WordPress Admin Panel**: Open `https://liyu-her.42.fr/wp-admin`
  - Log in using the administrator username `wpowner` and the password defined in `secrets/credentials.txt`.

---

## 4. Locate and Manage Credentials
Credentials are not stored in environment variables directly nor committed to Git. Instead, they are located inside the `secrets/` directory at the project root:
- `secrets/db_root_password.txt`: The root user password for MariaDB.
- `secrets/db_password.txt`: The database password used by the WordPress database user.
- `secrets/credentials.txt`: The WordPress admin account password. The WordPress regular user password is automatically derived as `<admin-password>_user`.

To change any password:
1. Run `make down` to stop the stack.
2. Update the value inside the corresponding secret file in the `secrets/` folder.
3. Run `make fclean && make` to recreate the database with the new passwords (Warning: This will clear existing site data).

---

## 5. Check That Services Are Running Correctly

You can verify container status using the standard Docker commands:

### List Active Containers:
```bash
docker compose -f srcs/docker-compose.yml ps
```
All containers (`nginx`, `wordpress`, `mariadb`) should have a status of `Up`.

### Check Logs:
To debug issues or inspect start routines, run:
```bash
docker compose -f srcs/docker-compose.yml logs -f
```

### Inspect Container Networks and Ports:
Verify Nginx is the only container mapping ports to the host:
```bash
docker ps
```
The output should show that port `443` is mapped only to the Nginx container.
