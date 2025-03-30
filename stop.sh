#!/bin/bash
# James Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# Minecraft Server stop script - primarily called by minecraft service but can be ran manually

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
  PATH="$USERPATH"
else
  echo "No se puede establecer la variable de ruta. Probablemente necesites descargar una versión actualizada de SetupMinecraft.sh desde GitHub!"
fi

# Check to make sure we aren't running as root
if [[ $(id -u) = 0 ]]; then
  echo "Este script no debe ejecutarse como root. Ejecute ./stop.sh como usuario no root, sin sudo. Saliendo.."
  exit 1
fi

# Check if server is running
if ! screen -list | grep -q '\.servername\s'; then
  echo "El servidor no se está ejecutando actualmente."
  exit 1
fi

# Get an optional custom countdown time (in minutes)
CountdownTime=0
while getopts ":t:" opt; do
  case $opt in
  t)
    case $OPTARG in
    '' | *[!0-9]*)
      echo "El tiempo de cuenta regresiva debe ser un número entero en minutos."
      exit 1
      ;;
    *)
      CountdownTime=$OPTARG >&2
      ;;
    esac
    ;;
  \?)
    echo "Invalid option: -$OPTARG; El tiempo de cuenta regresiva debe ser un número entero en minutos." >&2
    ;;
  esac
done

# Stop the server
while [[ $CountdownTime -gt 0 ]]; do
  if [[ $CountdownTime -eq 1 ]]; then
    screen -Rd servername -X stuff "say Detener el servidor en 60 segundos...$(printf '\r')"
    echo "Detener el servidor en 60 segundos..."
    sleep 30
    screen -Rd servername -X stuff "say Detener el servidor en 30 segundos...$(printf '\r')"
    echo "Detener el servidor en 30 segundos..."
    sleep 20
    screen -Rd servername -X stuff "say Detener el servidor en 10 segundos...$(printf '\r')"
    echo "Detener el servidor en 10 segundos..."
    sleep 10
    CountdownTime=$((CountdownTime - 1))
  else
    screen -Rd servername -X stuff "decir Deteniendo el servidor en $CountdownTime minutos...$(printf '\r')"
    echo "Deteniendo el servidor en $CountdownTime minutos...$(printf '\r')"
    sleep 60
    CountdownTime=$((CountdownTime - 1))
  fi
  echo "Esperando $CountdownTime minutos más..."
done
echo "Deteniendo el servidor de Minecraft ..."
screen -Rd servername -X stuff "say Deteniendo el servidor (stop.sh llamado)...$(printf '\r')"
screen -Rd servername -X stuff "stop$(printf '\r')"

# Wait up to 20 seconds for server to close
StopChecks=0
while [[ $StopChecks -lt 20 ]]; do
  if ! screen -list | grep -q '\.servername\s'; then
    break
  fi
  sleep 1
  StopChecks=$((StopChecks + 1))
done

# Force quit if server is still open
if screen -list | grep -q '\.servername\s'; then
  echo "El servidor de Minecraft aún no se ha detenido después de 20 segundos, cerrando la pantalla manualmente"
  screen -S servername -X quit
fi

echo "El servidor de Minecraft servername se detuvo."
