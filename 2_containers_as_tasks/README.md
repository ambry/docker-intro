# Part Two - Containers As Tasks

## Objective

* Use a container to build a react application
* Serve that application using nginx

## Build The Project

Use `docker pull` to pull down a nodejs image that we can use to build the project

    docker pull node:10-alpine

Run a node container with the command `npm install` to install the project dependencies. The project files must be
mounted as a volume and we need to specify the destination path as the working directory.

    docker run -v $(pwd):/app -w /app node:10-alpine npm install

After this command completes the container will stop and we should see a node_modules directory on the host machine.

Now that our dependencies are installed, we can build the project:

    docker run -v $(pwd):/app -w /app node:10-alpine npm run build

There should now be a build directory on the host machine.

## Serve The Project

Using the nginx container from Part One, we can run the react application we just built.

    docker run -p 80:80 -d -v $(pwd)/build:/app part_one_nginx

## Package It Together

The Dockerfile for this step uses a [multistage build](https://docs.docker.com/develop/develop-images/multistage-build/)
to build the application using a node container and then build an nginx container using the result of the node build
step.

    docker build -t part_two_nginx .
    docker container run -p 80:80 -d part_two_nginx
