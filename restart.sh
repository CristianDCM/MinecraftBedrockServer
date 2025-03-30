#!/bin/bash
# James Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# Minecraft Bedrock Server restart script

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
  PATH="$USERPATH"
else
  echo "No se puede establecer la variable de ruta. Probablemente necesites descargar una versión actualizada de SetupMinecraft.sh desde GitHub"
fi

# Check to make sure we aren't running as root
if [[ $(id -u) = 0 ]]; then
  echo "Este script no está diseñado para ejecutarse como root. Ejecute ./restart.sh como usuario no root, sin sudo. Saliendo..."
  exit 1
fi

# Check if server is started
if ! screen -list | grep -q '\.servername\s'; then
  echo "¡El servidor no está ejecutándose actualmente!"
  exit 1
fi

echo "Enviando notificaciones de reinicio al servidor..."

# Start countdown notice on server
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 30 segundos! $(printf '\r')"
sleep 23s
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 7 segundos! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 6 segundos! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 5 segundos! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 4 segundos! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 3 segundos! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 2 segundos! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "Digamos que el servidor se reiniciará en 1 segundo! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Cerrando servidor...$(printf '\r')"
screen -Rd servername -X stuff "stop$(printf '\r')"

echo "Cerrando servidor..."
# Wait up to 30 seconds for server to close
StopChecks=0
while [[ $StopChecks -lt 30 ]]; do
  if ! screen -list | grep -q '\.servername\s'; then
    break
  fi
  sleep 1
  StopChecks=$((StopChecks + 1))
done

if screen -list | grep -q '\.servername\s'; then
  # Server still hasn't stopped after 30s, tell Screen to close it
  echo "El servidor de Minecraft aún no se ha cerrado después de 30 segundos, cerrando la pantalla manualmente"
  screen -S servername -X quit
  sleep 10
fi

# Start server (start.sh) - comment out if you want to use systemd and have added a line to your sudoers allowing passwordless sudo for the start command using 'sudo visudo' and insert the example line below with the correct username
#/bin/bash dirname/minecraftbe/servername/start.sh

# EXAMPLE SUDO LINE
# minecraftuser ALL=(ALL) NOPASSWD: /bin/systemctl start yourservername

# If you have added the above example sudo line to your sudoers file with 'sudo visudo' and the correct username uncomment the line below (make sure you comment out the /bin/bash dirname/minecraftbe/servername/start.sh line)
sudo -n systemctl start servername
