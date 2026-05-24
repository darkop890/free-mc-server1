#!/bin/bash
echo "Updating system packages..."
sudo apt-get update -y && sudo apt-get install -y wget curl screen openjdk-17-jre-headless

# Download Minecraft Server (Paper MC 1.20.4 used as example)
if [ ! -f "server.jar" ]; then
    echo "Downloading Minecraft Server executable..."
    wget -O server.jar https://papermc.io
fi

# Accept Minecraft EULA automatically
echo "eula=true" > eula.txt

# Install Playit.gg network tunnel client for connection
if [ ! -f "playit" ]; then
    echo "Downloading Playit.gg network tunnel..."
    curl -SsL https://github.io -o playit
    chmod +x playit
fi

# Run the tunnel client in a detached terminal session
screen -dmS tunnel ./playit

# Fire up the Minecraft Server utilizing maximum RAM allocation
echo "Booting up the Minecraft Server..."
java -Xmx10G -Xms10G -jar server.jar nogui
