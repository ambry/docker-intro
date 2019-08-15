# Ambry Docker Introduction

## Installing Docker
### **IMPORTANT** (When running with vmware vm)
----------------------------------------------
Docker's filesystem will cause the VM we install docker on to freeze when backing up. Disabling the vmtools sync driver solves this.

Add the following to `/etc/vmware-tools/tools.conf`  (If the file doesn't exist then create it.)
```
[vmbackup]
enableSyncDriver = false
```
Then run:
```bash
sudo systemctl restart vmware-tools
```

### CentOS Docker Installation
> Taken directly from [docs.docker.com](https://docs.docker.com/install/linux/docker-ce/centos/)
##### Install required packages
```bash
sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
```

##### Add Docker's stable repository
```bash
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

##### Install Docker
```bash
sudo yum install -y docker-ce docker-ce-cli containerd.io
```

##### Add the current user to the docker group
> If you would like to use Docker as a non-root user, and not have to use `sudo` to run Docker, you should now consider adding your user to the “docker” group.
>
> **WARNING:**
> Adding a user to the “docker” group grants them the ability to run containers which can be used to obtain root privileges on the Docker host. Refer to Docker Daemon Attack Surface for more information.
```bash
sudo usermod -aG docker $USER
```
If you have added yourself to the `docker` group you need to log out in order for the changes to take effect.

##### Configure Docker to start on boot
```bash
sudo systemctl enable docker
```

##### Start the docker daemon
```bash
sudo systemctl start docker
```

## Installing Docker Compose:
[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration. 
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

#### Installation TLDR;
All of the above steps can be run through the installation script in the project root:
```bash
bash ./install.sh
```