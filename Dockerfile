# Use the official Apache HTTPD image from Docker Hub (Alpine version)
FROM httpd:alpine

# Install apache2-utils (for mod_status) and curl (for Prometheus integration)
RUN apk --no-cache add apache2-utils curl \
    && echo "LoadModule status_module modules/mod_status.so" >> /usr/local/apache2/conf/httpd.conf \
    && echo "Listen 8080" >> /usr/local/apache2/conf/httpd.conf \
    && echo "ServerStatus On" >> /usr/local/apache2/conf/httpd.conf \
    && echo "ExtendedStatus On" >> /usr/local/apache2/conf/httpd.conf \
    && echo "Alias /server-status /usr/local/apache2/logs/status.html" >> /usr/local/apache2/conf/httpd.conf \
    && echo "<Location /server-status>" >> /usr/local/apache2/conf/httpd.conf \
    && echo "    SetHandler server-status" >> /usr/local/apache2/conf/httpd.conf \
    && echo "    Require all granted" >> /usr/local/apache2/conf/httpd.conf \
    && echo "</Location>" >> /usr/local/apache2/conf/httpd.conf \
    && mkdir -p /usr/local/apache2/logs \
    && touch /usr/local/apache2/logs/status.html \
    && chmod -R 755 /usr/local/apache2/logs \
    && chown -R daemon:daemon /usr/local/apache2/logs \
    && rm -rf /var/cache/apk/*


# Copy your website files into the container (if you have any static content)
COPY ./ /usr/local/apache2/htdocs/

# Expose port 8080 for the HTTPD server
EXPOSE 8080

# Command to run the Apache HTTP server in the foreground
CMD ["httpd-foreground"]
