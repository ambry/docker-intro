##
# Use a node 10 container to build the application
##
FROM node:10.16-alpine as app_build

WORKDIR /app

COPY package.json package-lock.json ./
COPY public public/
COPY src src/

RUN npm install && npm run build

##
# Use an nginx container to run the application
##
FROM nginx:1.17-alpine

# Copy files from the build step into this container
COPY --from=app_build /app/build /app

COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
