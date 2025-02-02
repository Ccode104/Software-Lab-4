# Docker Setup and Usage Guide

## Step 1: Download and Install Docker
 Visit: Docker Documentation - Get Docker and download Docker Desktop.
 After successfully installing it, run the application.

---

## Step 2: Pulling a Docker Image
 Open the command prompt (`cmd`).
 Navigate to the directory where you want to store the files.
 Run the following command to pull the NGINX image:

   ```bash
   docker pull nginx
   ```

Once this command executes, the image will be downloaded successfully.

---

## Step 3: Running a Container
 To run the container, use the following command:

   ```bash
   docker run -p 8080:80 nginx
   ```

### Explanation:
This maps the host port `8080` to the container port `80`. Container processes run in isolation by default, so port pairing is necessary.

 Open your browser and visit: localhost:8080.
If the setup is successful, you will see the NGINX welcome page.

---

## Step 4: Managing Containers
### Stopping a Container
   ```bash
   docker stop container_name
   ```

### Viewing Running Containers
   ```bash
   docker ps
   ```
Lists all currently running containers. Use it to find the container’s name.

### Restarting a Container
   ```bash
   docker restart container_id
   ```
### The container ID can be retrieved using:
     ```bash
     docker ps -all
     ```

### Observation: 
The container resumes from its last saved state when restarted.

---

## Step 5: Removing a Container
First, stop the container if it is still running:
   ```bash
   docker stop container_name
   ```

 Then, remove the container to delete it completely:
   ```bash
   docker rm container_name
   ```

 Run the following command to see all containers (including stopped ones):
     ```bash
     docker ps -all
     ```

Once removed, the container no longer exists. However, the Docker image remains on your system.

---

## Notes
The Docker image is not deleted when you remove a container.
Once familiar with the commands, pulling and running a basic image like `hello-world` becomes straightforward.

---
