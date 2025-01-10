# Use the official httpd image from Docker Hub
FROM httpd:alpine



# Install mod_status and Prometheus exporter (mod_exporter) for Apache
RUN apk --no-cache add apache2-utils \
    && apk --no-cache add curl \
    && echo "ServerStatus On\nExtendedStatus On\n" >> /usr/local/apache2/conf/httpd.conf \
    && echo "Alias /server-status /usr/local/apache2/logs/status.html" >> /usr/local/apache2/conf/httpd.conf \
    && echo "<Location /server-status>\n    SetHandler server-status\n    Require local\n</Location>" >> /usr/local/apache2/conf/httpd.conf \
    && mkdir -p /usr/local/apache2/logs \
    && touch /usr/local/apache2/logs/status.html
# Copy the local directory contents into the container
# The httpd container serves files from /usr/local/apache2/htdocs by default
COPY . /usr/local/apache2/htdocs/

# Expose port 8080   EXPOSE 80 The server-status page is available on port 80 for Prometheus to scrape the Apache metrics.
EXPOSE 8080
# Command to run the Apache HTTP server
CMD ["httpd-foreground"]
