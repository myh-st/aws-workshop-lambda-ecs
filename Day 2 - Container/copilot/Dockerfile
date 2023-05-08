# Specify the base image to use
FROM nginx:latest

# Copy our index.html and styles.css files to the nginx document root
COPY index.html /usr/share/nginx/html/
COPY css/styles.css /usr/share/nginx/html/css/

# Expose port 80 for incoming HTTP traffic
EXPOSE 80

