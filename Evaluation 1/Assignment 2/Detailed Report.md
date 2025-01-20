# Getting Started with Docker: A Beginner's Guide

## Environment Setup

### Installing Docker
- For Windows and Mac users, Docker Desktop is available from the official website
- Linux users have distribution-specific installation methods
- After installation, Docker Desktop should be launched to verify proper setup

### Development Tools
A text editor is essential for working with Docker files. Popular options include:
- Visual Studio Code
- Vi/Vim

## Essential Docker Commands

Docker operations rely on several fundamental commands:
- `docker ps` - Display running containers
- `docker images` - Show available images
- `docker build` - Create Docker images
- `docker run` - Launch containers
- `docker login` - Access Docker Hub account
- `docker tag` - Apply tags to images
- `docker push` - Upload images to Docker Hub

## Creating Your First Web Application

### Project Structure
Begin by creating a dedicated project directory:

```bash
mkdir hello-docker
cd hello-docker
```

### Web Content
Create an `index.html` file with basic HTML content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hello Docker</title>
</head>
<body>
    <h1>Hello from Docker!</h1>
</body>
</html>
```

### Dockerfile Configuration

Create a Dockerfile with the following specifications:

```dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

This configuration:
- Uses nginx as the base image
- Copies the HTML file to the appropriate directory
- Exposes port 80 for web traffic
- Configures the nginx server startup command

### Building the Image

Execute the build command to create your Docker image:

```bash
docker build -t my-custom-image .
```

### Container Deployment

Launch the container and map the ports:

```bash
docker run -p 8080:80 my-custom-image
```

This command:
- Creates a bridge between host port 8080 and container port 80
- Makes the application accessible at `http://localhost:8080`

## Sharing Your Work

### Docker Hub Integration

To share your container image:

1. Register for a Docker Hub account
2. Authenticate via terminal:
```bash
docker login
```

3. Tag your image:
```bash
docker tag my-custom-image:latest yourusername/my-custom-image:latest
```

4. Upload to Docker Hub:
```bash
docker tag yourusername/my-custom-image:latest
```

After completion, your image becomes available for others to download and use through Docker Hub.
