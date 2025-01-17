# Use an official Nginx web server image as the base image
FROM nginx:latest

# Copy your HTML file from the host to the web server's document root
COPY index.html /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

# Define the command to start the web server
CMD ["nginx", "-g", "daemon off;"]
