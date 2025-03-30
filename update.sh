#!/bin/bash
# James Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# Minecraft Server update script - runs online SetupMinecraft.sh

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
   PATH="$USERPATH"
else
   echo "No se puede establecer la variable de ruta. Probablemente necesites descargar una versión actualizada de SetupMinecraft.sh desde GitHub!"
fi

# Check to make sure we aren't running as root
if [ $(id -u) = 0 ]; then
   echo "Este script no está diseñado para ejecutarse como root. Ejecute ./update.sh como usuario no root, sin sudo. Saliendo...."
   exit 1
fi

curl https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh | bash
