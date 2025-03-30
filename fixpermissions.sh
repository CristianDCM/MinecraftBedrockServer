#!/bin/bash
# Minecraft Server Permissions Fix Script - James A. Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/

# Takes ownership of server files to fix common permission errors such as access denied
# This is very common when restoring backups, moving and editing files, etc.

# If you are using the systemd service (sudo systemctl start servername) it performs this automatically for you each startup

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
  PATH="$USERPATH"
else
  echo "No se puede establecer la variable de ruta. Probablemente necesites descargar una versión actualizada de SetupMinecraft.sh desde GitHub"
fi

echo "Tomando propiedad de todos los files/folders del servidor en dirname/minecraftbe/servername..."
sudo -n chown -R userxname dirname/minecraftbe/servername
sudo -n chmod -R 755 dirname/minecraftbe/servername/*.sh
if [ -e dirname/minecraftbe/servername/bedrock_server ]; then
  sudo -n chmod 755 dirname/minecraftbe/servername/bedrock_server
  sudo -n chmod +x dirname/minecraftbe/servername/bedrock_server
fi

echo "Completo"
