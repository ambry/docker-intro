# Use the nginx alpine image as a starting point for this build
# https://hub.docker.com/_/nginx
FROM nginx:1.17-alpine

WORKDIR /app

# Copy files from the host to the container
COPY index.html ./
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf

# ADD would work as well in place of COPY
# ADD and COPY can both be used to add files to a container, ADD has additional capabilitites:
# - It can extract files from a tar
# - It can use a url as the source

# Expose the port nginx is listening on so it will be accessable from the host
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
