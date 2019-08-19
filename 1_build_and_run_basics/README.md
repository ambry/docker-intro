# Part One - Build Images and Run Containers

## Objective

Build and start an nginx docker container that serves an index.html file.

## Build The Image

To build an image from the Dockerfile in the current directory:

    docker build -t part_one_nginx .

After building the image, you should see your image when you run `docker image ls`

## Run the container

Use `docker container create` to create a container from the image we just built.

    docker container create part_one_nginx

The container should appear when you run `docker container ls -a`. The `-a` flag causes the command to list all
containers instead of just running containers. You should see a `CONTAINER ID` column in the output of the ls command.
You can use this ID to reference the container.

To start the container use:

    docker container start <CONTAINER_ID>

Running `docker container ls` should show that the container is running.

To view logs for the container run:

    docker container logs <CONTAINER_ID>

The container is running, however if we try to access the application from a browser we will get a connection refused
error. This is because port 80 is not published to the host machine. To fix this we will need to run a new container
with port 80 published.

To stop the container:

    docker container stop <CONTAINER_ID>

To create the container and publish port 80 on the container to port 80 on the host:

    docker container create -p 80:80 part_one_nginx

...or to create and start the container in one command:

    docker container run -p 80:80 part_one_nginx

...or use the docker run alias:

    docker run -p 80:80 part_one_nginx

The docker run command will run the container in the foreground. Any output sent to STDOUT or STDERR will appear in your
cli. The nginx container outputs access logs to STDOUT. 

To run the container "detached" from your cli you can include the `-d` option

    docker run -p 80:80 -d part_one_nginx

You can confirm the container is running by running `docker container ls`. You should see that the host port 80 is
mapped to the container port 80.

    0.0.0.0:80->80/tcp

You can attach the container by running:

    docker container attach <CONTAINER_ID>

To start a container with the current directory mounted, run:

    docker run -p 80:80 -d -v $(pwd):/app part_one_nginx

Now you can edit index.html and the changes will be reflected when you refresh the page in your browser.
