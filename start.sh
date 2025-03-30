#!/bin/bash
# Author: James Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# Minecraft Bedrock server startup script using screen

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
    echo "Este script no está diseñado para ejecutarse como root. Ejecute ./start.sh como usuario no root, sin sudo. Saliendo..."
    exit 1
fi

# Randomizer for user agent
RandNum=$((1 + $RANDOM % 5000))

# Check if server is already started
ScreenWipe=$(screen -wipe 2>&1)
if screen -list | grep -q '\.servername\s'; then
    echo "¡El servidor ya está iniciado! Pulsa screen -r servername para abrirlo"
    exit 1
fi

# Change directory to server directory
cd dirname/minecraftbe/servername

# Create logs/backups/downloads folder if it doesn't exist
if [ ! -d "logs" ]; then
    mkdir logs
fi
if [ ! -d "downloads" ]; then
    mkdir downloads
fi
if [ ! -d "backups" ]; then
    mkdir backups
fi

# Check if network interfaces are up
NetworkChecks=0
if [ -e '/sbin/route' ]; then
    DefaultRoute=$(/sbin/route -n | awk '$4 == "UG" {print $2}')
else
    DefaultRoute=$(route -n | awk '$4 == "UG" {print $2}')
fi
while [ -z "$DefaultRoute" ]; do
    echo "La interfaz de red no está activa, lo intentaré nuevamente en 1 segundo"
    sleep 1
    if [ -e '/sbin/route' ]; then
        DefaultRoute=$(/sbin/route -n | awk '$4 == "UG" {print $2}')
    else
        DefaultRoute=$(route -n | awk '$4 == "UG" {print $2}')
    fi
    NetworkChecks=$((NetworkChecks + 1))
    if [ $NetworkChecks -gt 20 ]; then
        echo "Se agotó el tiempo de espera para que apareciera la interfaz de red: se inició el servidor sin conexión de red..."
        break
    fi
done

# Take ownership of server files and set correct permissions
Permissions=$(sudo bash dirname/minecraftbe/servername/fixpermissions.sh -a)

# Create backup
if [ -d "worlds" ]; then
    echo "Backing up server (to minecraftbe/servername/backups folder)"
    if [ -n "$(which pigz)" ]; then
        echo "Realizar una copia de seguridad del servidor (varios núcleos) en minecraftbe/servername/backups folder"
        tar -I pigz -pvcf backups/$(date +%Y.%m.%d.%H.%M.%S).tar.gz worlds
    else
        echo "Realizar una copia de seguridad del servidor (de un solo núcleo) a minecraftbe/servername/backups folder"
        tar -pzvcf backups/$(date +%Y.%m.%d.%H.%M.%S).tar.gz worlds
    fi
fi

# Rotate backups -- keep most recent 10
Rotate=$(
    pushd dirname/minecraftbe/servername/backups
    ls -1tr | head -n -10 | xargs -d '\n' rm -f --
    popd
)

# Retrieve latest version of Minecraft Bedrock dedicated server
echo "Comprobando la última versión del servidor Bedrock de Minecraft ..."

# Test internet connectivity first
curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RandNum.212 Safari/537.36" -s https://www.minecraft.net/ -o /dev/null
if [ "$?" != 0 ]; then
    echo "No se puede conectar al sitio web de actualización (es posible que la conexión a internet no funcione). Se omite la actualización...."
else
    # Download server index.html to check latest version

    curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RandNum.212 Safari/537.36" -o downloads/version.html https://www.minecraft.net/en-us/download/server/bedrock
    LatestURL=$(grep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/[^"]*' downloads/version.html)

    LatestFile=$(echo "$LatestURL" | sed 's#.*/##')

    echo "La última versión en línea es $LatestFile"
    if [ -e version_pin.txt ]; then
        echo "Se encontró version_pin.txt con la versión de anulación, utilizando la versión especificada: $(cat version_pin.txt)"
        PinFile=$(cat version_pin.txt)
    fi

    if [ -e version_installed.txt ]; then
        InstalledFile=$(cat version_installed.txt)
        echo "La instalación actual es: $InstalledFile"
    fi

    if [[ "$PinFile" == *"zip" ]] && [[ "$InstalledFile" == "$PinFile" ]]; then
        echo "La versión solicitada $PinFile ya está instalada"
    elif [ ! -z "$PinFile" ]; then
        echo "Instalación $PinFile"
        DownloadFile=$PinFile
        DownloadURL="https://www.minecraft.net/bedrockdedicatedserver/bin-linux/$PinFile"

        # Download version of Minecraft Bedrock dedicated server if it's not already local
        if [ ! -f "downloads/$DownloadFile" ]; then
            curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RandNum.212 Safari/537.36" -o "downloads/$DownloadFile" "$DownloadURL"
        fi

        # Install version of Minecraft requested
        if [ ! -z "$DownloadFile" ]; then
            if [ ! -e dirname/minecraftbe/servername/server.properties ]; then
                unzip -o "downloads/$DownloadFile" -x "*permissions.json*" "*whitelist.json*" "*valid_known_packs.json*" "*allowlist.json*"
            else
                unzip -o "downloads/$DownloadFile" -x "*server.properties*" "*permissions.json*" "*whitelist.json*" "*valid_known_packs.json*" "*allowlist.json*"
            fi
            Permissions=$(chmod u+x dirname/minecraftbe/servername/bedrock_server >/dev/null)
            echo "$DownloadFile" >version_installed.txt
        fi
    elif [[ "$InstalledFile" == "$LatestFile" ]]; then
        echo "La última versión $LatestFile ya está instalada"
    else
        echo "Instalación $LatestFile"
        DownloadFile=$LatestFile
        DownloadURL=$LatestURL

        # Download version of Minecraft Bedrock dedicated server if it's not already local
        if [ ! -f "downloads/$DownloadFile" ]; then
            curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RandNum.212 Safari/537.36" -o "downloads/$DownloadFile" "$DownloadURL"
        fi

        # Install version of Minecraft requested
        if [ ! -z "$DownloadFile" ]; then
            if [ ! -e dirname/minecraftbe/servername/server.properties ]; then
                unzip -o "downloads/$DownloadFile" -x "*permissions.json*" "*whitelist.json*" "*valid_known_packs.json*" "*allowlist.json*"
            else
                unzip -o "downloads/$DownloadFile" -x "*server.properties*" "*permissions.json*" "*whitelist.json*" "*valid_known_packs.json*" "*allowlist.json*"
            fi
            Permissions=$(chmod u+x dirname/minecraftbe/servername/bedrock_server >/dev/null)
            echo "$DownloadFile" >version_installed.txt
        fi
    fi
fi

if [ ! -e dirname/minecraftbe/servername/allowlist.json ]; then
    echo "Creando valor predeterminado allowlist.json..."
    echo '[]' >dirname/minecraftbe/servername/allowlist.json
fi
if [ ! -e dirname/minecraftbe/servername/permissions.json ]; then
    echo "Creando valor predeterminado permissions.json..."
    echo '[]' >dirname/minecraftbe/servername/permissions.json
fi
ContentLogging=$(grep "content-log-file-enabled" dirname/minecraftbe/servername/server.properties)
if [ -z "$ContentLogging" ]; then
    echo "" >> dirname/minecraftbe/servername/server.properties
    echo "content-log-file-enabled=true" >> dirname/minecraftbe/servername/server.properties
    echo "# Permite registrar errores de contenido en un archivo" >> dirname/minecraftbe/servername/server.properties
fi

echo "Iniciando el servidor de Minecraft. Para ver la ventana, escribe screen -r servername"
echo "TPara minimizar la ventana y dejar que el servidor se ejecute en segundo plano, presione Ctrl+A y luego Ctrl+D"

CPUArch=$(uname -m)
if [[ "$CPUArch" == *"aarch64"* ]]; then
    cd dirname/minecraftbe/servername
    if [ -n "$(which box64)" ]; then
        BASH_CMD="box64 bedrock_server"
    else
        BASH_CMD="LD_LIBRARY_PATH=dirname/minecraftbe/servername dirname/minecraftbe/servername/bedrock_server"
    fi
else
    BASH_CMD="LD_LIBRARY_PATH=dirname/minecraftbe/servername dirname/minecraftbe/servername/bedrock_server"
fi

if command -v gawk &>/dev/null; then
    BASH_CMD+=$' | gawk \'{ print strftime(\"[%Y-%m-%d %H:%M:%S]\"), $0 }\''
else
    echo "No se encontró la aplicación gawk; las marcas de tiempo no estarán disponibles en los registros. Elimine SetupMinecraft.sh y ejecute el script de la nueva manera recomendada!"
fi
screen -L -Logfile logs/servername.$(date +%Y.%m.%d.%H.%M.%S).log -dmS servername /bin/bash -c "${BASH_CMD}"
