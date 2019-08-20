# Part Three - Handling Multiple Containers

## Objective

Serve a Symfony application running in a PHP-FPM container from an nginx container

## Build The Images
3.1) 

    docker build -t part_three_app app
    docker build -t part_three_nginx nginx

## Run The Containers

3.2) It is important that we assign a name to the FPM container since it will need to be references from the nginx container.

    docker run -d --name app part_three_app
    docker run -d -p 80:80 --name nginx part_three_nginx

3.3) We can use `docker exec` to inspect the app container and confirm it was correctly built.

    docker exec -it app /bin/sh

## Network The Containers

3.4) Nginx cannot resolve the host "app" because the containers are not on the same network. To allow the containers to
communicate we need to create a network and add both containers.

    docker network create --attachable app_net
    docker network connect app_net app

3.5) We can simply attach the running app container to the network. Nginx, however has stopped because it failed to resolve
the FPM container. We must remove the container and run it again passing in the `--network` option.

    docker container rm nginx
    docker run -d -p 80:80 --network app_net --name nginx part_three_nginx



## Command References
- [`docker build`](https://docs.docker.com/engine/reference/commandline/build/)
- [`docker container`](https://docs.docker.com/engine/reference/commandline/conainer/)
- [`docker exec`](https://docs.docker.com/engine/reference/commandline/exec/)
- [`docker network`](https://docs.docker.com/engine/reference/commandline/network/)
- [`docker pull`](https://docs.docker.com/engine/reference/commandline/pull/)
- [`docker run`](https://docs.docker.com/engine/reference/commandline/run/)