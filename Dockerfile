# Use Nginx as the base image
FROM nginx:alpine

# Copy the custom nginx.conf into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy website files into the container's html directory
COPY ./ /usr/share/nginx/html/

# Expose port 8080 for external access
EXPOSE 8080

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
