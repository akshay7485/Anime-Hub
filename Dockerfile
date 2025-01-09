# Use the official httpd image from Docker Hub
FROM httpd:alpine

# Copy the local directory contents into the container
# The httpd container serves files from /usr/local/apache2/htdocs by default
COPY . /usr/local/apache2/htdocs/

# Expose port 8080
EXPOSE 8080
