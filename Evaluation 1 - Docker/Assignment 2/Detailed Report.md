#  Building Custom Docker Images

## Summary
This report documents the process and technical requirements for creating and deploying a basic Docker container. The implementation focuses on a simple web application using nginx as the base image, demonstrating fundamental Docker concepts and deployment practices.

## Technical Requirements

### System Prerequisites
- Docker Desktop (Windows/Mac)

### Command Line Tools
Some commonly used Docker commands for operations:
```bash
docker ps
docker images
docker build
docker run
docker login
docker tag
docker push
```

## Implementation Details

### Project Implementation
The development process involves creating a basic web application containerized using Docker. The project structure consists of two primary files:

1. Web Application File (`index.html`):
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

2. Container Configuration (`Dockerfile`):
```dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Deployment Process

The deployment workflow consists of the following steps:

1. Image Creation:
```bash
docker build -t my-custom-image .
```

2. Container Deployment:
```bash
docker run -p 8080:80 my-custom-image
```

### Distribution Protocol

For distribution purposes, the following steps are implemented:

1. Authentication:
```bash
docker login
```

2. Image Tagging:
```bash
docker tag my-custom-image:latest yourusername/my-custom-image:latest
```

3. Repository Upload:
```bash
docker push yourusername/my-custom-image:latest
```

## Technical Specifications

### Port Configuration
- Container Port: 80 (Internal)
- Host Port: 8080 (External)
- Access URL: http://localhost:8080

### Base Image
- nginx:latest
- Configured for HTTP service
- Default web server configuration

## Conclusion
The implemented Docker container solution provides a foundational framework for web application deployment. The configuration ensures proper isolation, portability, and distribution capabilities while maintaining standard web serving functionality.
