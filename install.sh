#!/usr/bin/env bash

VMWARE_TOOLS_CONF_DIR=/etc/vmware-tools

# If this directory exists we are most likely in a vmware vm 
# and need to disable the syncDriver in the tools.conf file
if [[ -d "$VMWARE_TOOLS_CONF_DIR" ]]; then
    VMWARE_TOOLS_CONF="$VMWARE_TOOLS_CONF_DIR/tools.conf"

    if [[ ! -f "$VMWARE_TOOLS_CONF" ]]; then
        printf "[vmbackup]\nenableSyncDriver = false" >> "$VMWARE_TOOLS_CONF"
        # Restarts to ingest new config
        sudo systemctl restart vmware-tools
    elif ! grep -q "enableSyncDriver" "$VMWARE_TOOLS_CONF"
    then
        echo -e "\e[31m$VMWARE_TOOLS_CONF found without \e[1;4menableSyncDriver\e[0m \e[31moption set\e[0m"
        echo -e "Make sure the following is in your \e[1;4m$VMWARE_TOOLS_CONF\e[0m file"
        echo ""
        echo "[vmbackup]"
        echo "enableSyncDriver = false"
        exit 1
    fi
fi


# Install Docker
echo "Installing Docker"
curl -s https://get.docker.com/ | bash -s

# Add current user to the docker group to avoid having to run with sudo.
# Warning: The docker group grants privileges equivalent to the root user.
echo "Adding $USER to docker group"
sudo usermod -aG docker $USER

# Configure Docker to start on boot
echo "Configuring Docker to start on boot"
sudo systemctl enable docker


# Install Docker Compose
echo "Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installed:"
docker --version || echo "Please logout and log back in for your group permission to access docker to take effect"
docker-compose --version
exit