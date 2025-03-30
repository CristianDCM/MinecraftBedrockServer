# Minecraft Bedrock Server

[日本語版 README はこちら](https://github.com/TheRemote/MinecraftBedrockServer/blob/master/README_jp.md)

Configura un servidor dedicado de Minecraft Bedrock en Ubuntu/Debian con opciones de actualizaciones automáticas, copias de seguridad y ejecución automática al inicio.<br>
Consulta las instrucciones de instalación en: https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/<br>
<br>
Si buscas una versión en contenedores Docker del servidor dedicado de Minecraft Bedrock, está disponible aquí: <a href="https://github.com/TheRemote/Legendary-Bedrock-Container">https://github.com/TheRemote/Legendary-Bedrock-Container</a>

<h2>Características</h2>
<ul>
<li>Configura el servidor oficial de Minecraft Bedrock (actualmente en fase alfa)</li>
<li>Servidor de Minecraft edición Bedrock totalmente operativo en un par de minutos</li>
<li>Compatible con distribuciones Ubuntu/Debian</li>
<li>Configura Minecraft como un servicio del sistema con opción de inicio automático al arrancar</li>
<li>Copias de seguridad automáticas al reiniciar el servidor</li>
<li>Compatible con múltiples instancias: puedes ejecutar varios servidores Bedrock en el mismo sistema</li>
<li>Se actualiza automáticamente a la última versión o a la definida por el usuario al iniciar el servidor</li>
<li>Fácil control del servidor con los scripts start.sh, stop.sh y restart.sh</li>
<li>Añade registro con marcas de tiempo al directorio "logs"</li>
<li>Reinicio diario programado opcional del servidor mediante cron</li>
<li>*NUEVO* Compatibilidad con Box64 para ARM de 64 bits (aarch64), que mejora considerablemente la velocidad de emulación en comparación con QEMU al traducir algunas llamadas del sistema a llamadas nativas del sistema.</li>
</ul>

<h2>Instrucciones rápidas de instalación</h2>
Para ejecutar la instalación, escriba:<br>
<pre>curl https://raw.githubusercontent.com/CristianDCM/MinecraftBedrockServer/master/SetupMinecraft.sh | bash</pre>

<h2>Guía de instalación</h2>
<a href="https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/">Guía de instalación y configuración del script del servidor dedicado de Minecraft Bedrock</a>

<h2>Instalación de paquetes de recursos / Compatibilidad con RTX</h2>
<p>Para obtener instrucciones sobre cómo instalar paquetes de recursos (incluida la compatibilidad opcional con RTX), consulta mi <a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener">guía paso a paso de los paquetes de recursos del servidor dedicado de Minecraft Bedrock / RTX opcional aquí</a>.</p>

<h2>Distribuciones probadas</h2>
<ul>
<li>Ubuntu / Ubuntu Server 22.04</li>
<li>Ubuntu / Ubuntu Servidor 20.04</li> 
<li>Ubuntu/Ubuntu Servidor 18.04</li> 
<li>Debian Stretch/Buster</li>
</ul>
  
<h2>Tested Platforms</h2>
<ul>
 <li>All PC X86_64 (WORKING)</li>
 <li><a href="https://jamesachambers.com/udoo-x86-microboard-breakdown/">Udoo X86 (WORKING)</a></li>
 <li><a href="https://jamesachambers.com/install-ubuntu-server-18-04-on-intel-compute-stick-guide/">Intel Compute Stick (WORKING)</a></li>
 <li>Other X86_64 platforms (WORKING)</li>
  <ul><li>ARM 64bit (WORKING -- speed improved with Box64)</li>
    <ul>
      <li>Raspberry Pi 64 bit (WORKING -- Box64)</li>
      <li>Raspberry Pi 32 bit (WORKING -- VERY SLOW -- 64 bit recommended!)</li>
      <li>Tinkerboard (WORKING, 32 bit is slow, 64 bit uses Box64)</li>
    </ul>
  </ul>
</ul>
Múltiples servidores y rutas de instalación
<p>El servidor admite varios servidores simultáneamente. Al ejecutar SetupMinecraft.sh de nuevo, seleccione la misma ruta raíz que para los servidores anteriores. La estructura de ruta de los scripts es $ROOTPATH/minecraftbe/yourservername, por lo que la ruta raíz que SetupMinecraft.sh solicita siempre debe ser la misma.
<p>La carpeta del servidor individual se determina por el nombre del servidor que introduzca. Si se trata de un servidor existente, los scripts se actualizarán de forma segura. Si se trata de un servidor nuevo, se creará una nueva carpeta en $ROOTPATH/minecraftbe/newservername.</p>
<p>Mantén la misma ruta de instalación para todos los servidores y el script se encargará de todo.</p>

<h2>Anulación de versión</h2>
Puedes volver a una versión anterior con el script revert.sh incluido en tu directorio, como se muestra a continuación: <pre>./revert.sh
Establece la versión anterior en version_pin.txt: bedrock-server-1.19.10.20.zip</pre>
Si tienes una versión específica que quieres ejecutar, también puedes crear version_pin.txt tú mismo, como se muestra a continuación: <pre>echo "bedrock-server-1.18.33.02.zip" > version_pin.txt</pre>
La retención de la versión se puede eliminar eliminando version_pin.txt. Esto permitirá que se actualice a la última versión.

Nota de solución de problemas: Máquinas virtuales de Oracle
Un problema muy común con los tutoriales de máquinas virtuales de Oracle, que suelen mostrar cómo usar una máquina virtual gratuita, es que la configuración de esta es mucho más difícil que la de casi cualquier otro producto u oferta.
El síntoma que se produce es que nadie podrá conectarse. Esto no se debe al segundo conjunto de puertos que se muestra después del inicio (un error de Bedrock de hace casi 3 o 4 años que todos los servidores presentan).
Sino a que hay varios pasos que se deben seguir para abrir los puertos en la máquina virtual de Oracle. Es necesario:

<ul>
<li>Configurar los puertos de entrada (TCP/UDP) en la lista de seguridad de la red virtual en la nube (VCN)</li>

*y* configurar los puertos de entrada en un grupo de seguridad de red asignado a la instancia</li>
</ul><br>
Ambas configuraciones suelen ser necesarias para poder conectarse a la instancia de la máquina virtual. Esto es puramente de configuración y no tiene nada que ver con el script ni con el servidor de Minecraft.<br><br>
No recomiendo esta plataforma debido a la dificultad de configuración, pero quienes han tenido que configurar una máquina virtual Oracle han tenido buenas experiencias con ella posteriormente. Solo tengan en cuenta que la configuración será un proceso complicado para la mayoría de las personas.<br><br>
Aquí hay información adicional. Enlaces:<br>
<ul>
<li>https://jamesachambers.com/official-minecraft-bedrock-dedicated-server-on-raspberry-pi/comment-page-8/#comment-13946</li>
<li>https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/comment-page-53/#comment-13936</li>
<li>https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/comment-page-49/#comment-13377</li>
<li>https://jamesachambers.com/legendary-minecraft-bedrock-container/comment-page-2/#comment-13706</li>
</ul>

Nota de solución de problemas: Hyper-V
Hay un error extraño en Hyper-V que interrumpe las conexiones UDP en el servidor de Minecraft. La solución es usar una máquina virtual de Generación 1 con el controlador de red LAN heredado.<br>
Consulta los siguientes enlaces:<br>
<ul>
<li>https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/comment-page-54/#comment-13863</li>
<li>https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/comment-page-56/#comment-14207</li>
</ul>

<h2>Comprar un café / Donar</h2>
<p>Hay gente interesada en esto (¡son todos unos santos, gracias de verdad!)</p>
<ul>
<li>PayPal: 05jchambers@gmail.com</li>
<li>Venmo: @JamesAChambers</li>
<li>CashApp: $theremote</li>
<li>Bitcoin (BTC): 3H6wkPnL1Kvne7dJQS8h7wB4vndB9KxZP7</li>
</ul>

<h2>Historial de actualizaciones</h2>
<ul>
<li>1 de diciembre de 2024</li>
<ul>
<li>URL de descarga corregida</li>
</ul>
<li>1 de octubre de 2023</li>
<ul>
<li>Importación de claves GPG corregida para compilaciones ARM64</li>
</ul>
<li>14 de enero de 2023</li>
<ul>
<li>Cambiar la comprobación de conectividad de google.com a minecraft.net para evitar bloqueos en algunos países</li>
</ul>
<li>4 de septiembre 2022</li>
<ul>
<li>Eliminar código innecesario de fixpermissions.sh</li>
</ul>
<li>12 de agosto de 2022</li>
<ul>
<li>Añadir el script de la utilidad clean.sh para limpiar la carpeta de descargas, eliminar la fijación de versiones y forzar la reinstalación de la versión actual</li>
<li>Habilitar el registro de contenido predeterminado, que muestra errores relacionados con los paquetes de recursos/comportamiento</li>
</ul>
<li>12 de agosto de 2022</li>
<ul>
<li>Añadir el script de la utilidad clean.sh para limpiar la carpeta de descargas, eliminar la fijación de versiones y forzar la reinstalación de la versión actual</li>
<li>Habilitar el registro de contenido predeterminado, que muestra errores relacionados con los paquetes de recursos/comportamiento</li>
</ul>
<li>10 de agosto de 2022</li>
<ul>
<li>Se movió la variable DirName a una variable personalizada en la parte superior de SetupMinecraft.sh</li>
</ul>
<li>4 de agosto de 2022</li>
<ul>
<li>El script ahora elimina los caracteres no alfanuméricos de la variable servername (para evitar el uso de comillas y otros símbolos que la interrumpan).</li>
</ul>
<li>2 de agosto de 2022</li>
<ul>
<li>Se ha añadido compatibilidad con Box64 para ARM de 64 bits (aarch64). No se recomienda usar ARM de 32 bits, ya que no puede usar Box64, por lo que será mucho más lento que si instala una versión de 64 bits de su sistema operativo en el dispositivo.</li>
<li>Debe usar un sistema operativo de 64 bits para beneficiarse de las velocidades mejoradas de Box64 (tanto Ubuntu como Raspberry Pi tienen versiones de 64 bits).</li>
<li>Una forma sencilla de comprobar que usa 64 bits es usar <pre>uname -m</pre>, que devolverá "aarch64" si usa ARM de 64 bits.</li>
</ul>
<li>24 de julio de 2022</li>
<ul>
        <li>Usar libssl1.1 del repositorio en lugar de servidores Ubuntu, ya que cambia cada una o dos semanas (gracias a theblujuice, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/129">problema n.° 129)</a></li>
</ul>
<li>21 de julio de 2022</li>
<ul>
<li>Aumentar el tiempo de espera en minecraftbe.service para evitar que los servidores con tiempos de copia de seguridad más largos tengan problemas de inicio</li>
</ul>
<li>19 de julio de 2022</li>
<ul>
<li>Corregir un error de sintaxis menor en update.sh</li>
</ul>
<li>14 de julio de 2022</li>
<ul>
<li>Corregir un error de sintaxis en la nueva instalación de libssl3</li>
<li>Actualizar el archivo depends.zip para dispositivos ARM (el Se recomienda encarecidamente la versión de Docker para dispositivos ARM.</li>
</ul>
<li>14 de julio de 2022</li>
<ul>
<li>Añadir libssl3 a las dependencias</li>
</ul>
<li>7 de julio de 2022</li>
<ul>
<li>Actualizar la URL de instalación de respaldo de curl al paquete más reciente</li>
<li>Correcciones de puntuación y gramática en el archivo README (gracias a TheWilbo, <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/128">solicitud de extracción n.° 128)</a></li>
</ul>
<li>11 de junio de 2022</li>
<ul>
<li>Añadir los archivos de plantilla predeterminados allowlist.json y permissions.json para evitar fallos cuando faltan (gracias a Eike)</li>
</ul>
<li>Junio 10 de 2022</li>
<ul>
<li>Se solucionó el problema al escapar el comando screen en SetupMinecraft.sh (en la comprobación de inicio).</li>
</ul>
<li>5 de junio de 2022</li>
<ul>
<li>Se añadió un escape adicional a los comandos screen -list para evitar que nombres similares coincidan con la consulta grep (gracias, wheelibin).</li>
<li>Se modificó el comando grep -q para usar comillas simples y evitar la expansión de caracteres adicionales (sigo recomendando solo letras y números para la etiqueta/nombre del servidor para minimizar los problemas).</li>
</ul>
<li>31 de mayo de 2022</li>
<ul>
<li>Se añadió una comprobación para asegurar que server.properties exista al descomprimir el servidor, ya que sin ella se producirá un error de inicio.</li>
</ul>
<li>26 de mayo de 2022</li>
<ul>
<li>Se añadió revert.sh Para descargar SetupMinecraft.sh</li>
<li>Añadir documentación sobre la anulación de la versión</li>
</ul>
<li>25 de mayo de 2022</li>
<ul>
        Se agregó version_pin.txt para permitir la anulación manual de la versión del servidor en ejecución. Ejecute ./revert.sh en la carpeta del servidor para configurar la versión n-1 para que se ejecute en el próximo reinicio. Elimine version_pin.txt si desea reanudar las actualizaciones automáticas. (Gracias, smallsam)</li>
</ul>
<li>15 de mayo de 2022</li>
<ul>
<li>Se añadió el borrado de pantalla al principio de start.sh para evitar un problema de inicio que podría ocurrir si hubiera una instancia de pantalla "muerta" (Gracias, grimholme)</li>
</ul>
<li>9 de mayo de 2022</li>
<ul>
<li>Se actualizó la URL de instalación de respaldo para OpenSSL 1.1</li>
</ul>
<li>4 de mayo de 2022</li>
<ul>
<li>Se solucionó un problema en Debian donde el comando de ruta (/sbin/route) no está en la ruta predeterminada agregando una verificación para esto</li>
<li>Se agregó Ubuntu 22.04 a la lista de distribuciones probadas (actualicé mi sistema operativo de escritorio a este hoy)</li>
</ul>
<li>28 de abril 2022</li>
<ul>
<li>Se corrigió una línea en fixpermissions.sh que podía provocar problemas en las shells exigentes</li>
</ul>
<li>24 de abril de 2022</li>
<ul>
<li>Se añadió la instalación del paquete de dependencia para libssl1.1 cuando esté disponible en apt</li>
<li>Se añadió una instalación de respaldo para libssl1.1 con la esperanza de corregir el instalador para Ubuntu 22.04/22.10 y otras distribuciones que usan libssl3</li>
<li>Se corrigió un pequeño mensaje de error de cola que podía aparecer al iniciar el servidor si aún no se habían creado registros</li>
<li>Se añadió DEBIAN_NONINTERACTIVE a algunos comandos de apt para intentar suprimir algunos diálogos interactivos (como la ejecución de un kernel desactualizado) que provocaban que el instalador se bloqueara</li>
<li>Se corrigió un error en la nueva versión multinúcleo La copia de seguridad provocaba que seleccionara el compresor incorrecto.</li>
</ul>
<li>16 de abril de 2022</li>
<ul>
<li>Se añadió compatibilidad con varios núcleos de CPU para las copias de seguridad, lo que debería acelerar el proceso.</li>
</ul>
<li>19 de marzo de 2022</li>
<ul>
<li>Se eliminó el calificador /sbin del comando de ruta, ya que SetupMinecraft.sh ahora almacena la variable PATH al principio de cada script (gracias a LookedPath, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/120">problema n.° 120</a>).</li>
</ul>
<li>10 de marzo de 2022</li>
<ul>
<li>Se añadió el nuevo archivo allowlist.json a la lista blanca de descompresión (gracias a shaman79, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/118">problema n.° 118</a>)</li>
<li>Se agregó información para comprar un café y hacer donaciones (gracias a vandersonmota, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/117">problema n.° 117</a>)</li>
</ul>
<li>2 de noviembre de 2021</li>
<ul>
<li>Se corrigió un error adicional/delante del script de corrección de permisos (gracias a MarkBarbieri, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/109">problema n.° 109</a>)</li>
</ul>
<li>31 de octubre de 2021</li>
<ul>
<li>Se corrigió la falta de sudo en la línea fixpermissions en start.sh (gracias a MarkBarbieri, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/109">problema n.° 109</a>)</li>
<li>Se corrigió la falta del parámetro -a del archivo /etc/sudoers. Añadido gracias a MarkBarbieri, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/109">problema n.° 109</a>)</li>
</ul>
<li>1 de agosto de 2021</li>
<ul>
<li>Se actualizó la documentación y el mensaje de selección de la ruta raíz para aclarar que el directorio raíz debe ser el mismo para TODOS los servidores.</li>
<li>No lo cambie a menos que instale en un disco diferente. En ese caso, use la misma ruta raíz para TODOS los servidores, ya que seguirán la estructura $ROOTPATH/minecraftbe/yourservername</li>
<li>Seleccionar una tormenta perfecta de rutas no válidas. Esto ha provocado que los archivos del servidor de otros usuarios se hayan podado anteriormente debido a un error en un subnivel de carpeta, etc. Sigue atentamente las instrucciones aquí, no las modifiques y asegúrate de tener copias de seguridad (fuera de la carpeta principal de copias de seguridad de Minecraft) antes de intentar instalar un servidor adicional o actualizar scripts existentes.

<li>Afortunadamente, esta persona estaba iniciando un nuevo servidor, así que la poda no se volvió grave, pero insisto en que no se modifiquen las rutas a menos que seas un experto en un caso práctico como tener un disco completo separado para todos los servidores de Minecraft. ¡Usa el mismo directorio raíz siempre (preferiblemente el predeterminado)!</li>

</ul>
  <li>27 de julio de 2021</li>
<ul>
<li>Se limpió SetupMinecraft.sh y se eliminó el código redundante organizándolo en funciones</li>
<li>Los scripts ahora corrigen todos los permisos de los archivos del servidor al iniciar</li>
<li>Se añadió el archivo /etc/sudoers.d/minecraftbe para incluir el permiso sudo sin contraseña para fixpermissions y sudo systemctl start server</li>
</ul>
<li>21 de julio de 2021</li>
<ul>
<li>Se actualizó la documentación y restart.sh para documentar cómo habilitar que el servicio systemd se muestre como "en línea" después de ser llamado por restart.sh (útil para quienes rastrean los servidores que usan el servicio systemd). Se agregó una línea al archivo sudoers para permitir el uso de sudo sin contraseña para el comando sudo systemctl start yourservername. Restart.sh ahora incluye líneas comentadas al final, junto con instrucciones sobre cómo habilitar esta función si la necesita (la mayoría probablemente no la necesite).

<li>Se agregó la redirección de errores a la línea crontab para ayudar a diagnosticar fallos durante los reinicios programados y se eliminó ExecStartPre del servicio, ya que no hacía nada (ejecute ./fixpermissions.sh si necesita corregir los permisos) y causaba problemas de compatibilidad con versiones anteriores de systemd.

<li>17 de julio de 2021</li>

<ul>

<li>Se agregó una comprobación para garantizar que start.sh y otros scripts no se ejecuten como root. Si esto ocurre, debes usar sudo screen -r para encontrar la pantalla y los permisos serán incorrectos, ya que root no es el propietario de los archivos del servidor.</li>
<li>Si sabes que ejecutaste el script o el servidor como root (lo que crea archivos propiedad de root en lugar del usuario normal) y tu servidor no arranca o funciona mal, ejecuta el script fixpermissions desde la carpeta del servidor con ./fixpermissions.sh y los corregirá automáticamente.</li>
</ul>
<li>15 de julio de 2021</li>
<ul>
<li>Se agregó el script de conveniencia update.sh para ejecutar SetupMinecraft.sh y actualizar todo a la última versión.</li>
<li>Se agregó un bucle de validación para la ruta del directorio: si actualizas desde una versión anterior, debes usar el directorio predeterminado.</li>
<li>Cambiar esto no tiene ningún efecto positivo y nunca he visto ni oído que resuelva ningún problema, a pesar de que se ha solicitado durante años (especialmente si no entiendes las rutas de acceso relativas y completas de Linux). y otras dificultades: ¡déjenlo por defecto!).</li>
<li>Intento resolver este problema con comprobaciones de seguridad por si acaso les resulta útil a algunas personas, pero no he oído hablar de ello, pero es posible que se elimine por completo o se convierta en una comprobación que deba descargar y modificar el script para habilitarla si sigue siendo una fuente de problemas.</li>
<li>Depends.zip actualizado para Raspberry Pis</li>
</ul>
<li>4 de julio de 2021</li>
<ul>
<li>Se añadió la línea sudo que faltaba en algunos prerrequisitos y se eliminó apt-get install sudo, ya que el script ya no se ejecuta como root (instalar sudo si falta). Gracias, Rick Horn.</li>
</ul>
<li>3 de julio de 2021</li>
<ul>
<li>Se añadió el encabezado Accept-Encoding: Identity a curl, ya que un porcentaje muy pequeño de usuarios recibe un error de "Acceso denegado" sin este encabezado (gracias, titiscan). <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/95">solicitud de extracción n.° 95</a></li>
<li>Se añadió el encabezado de idioma predeterminado a curl, ya que las computadoras que no estaban en inglés recibían un error de acceso denegado.</li>
<li>El script ahora comprueba si gawk está presente en start.sh. Si no está instalado (probablemente debido a la reutilización de archivos antiguos de SetupMinecraft.sh), se deshabilitarán las marcas de tiempo. Esto evitará que el servidor falle al iniciarse. Esto se evita al no ejecutar una copia antigua de SetupMinecraft.sh.</li>
<li>Se eliminó el comando screen -r al final de SetupMinecraft.sh, ya que corregirlo causaba bloqueos. En su lugar, ahora se muestra el comando (screen -r) para abrir la consola de Minecraft. Presiona Ctrl+A y luego Ctrl+D para ocultar la consola una vez dentro.</li>
<li>Se agregó código para evitar que SetupMinecraft.sh se ejecute como un archivo local (usa el nuevo método curl https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh | bash)</li>
</ul>
  2 de julio de 2021

<ul>
<li>Detección e instalación de dependencias mejoradas

<li>Dependencia wget eliminada

<li>Dependencia gawk añadida. Esto no debería afectar a la mayoría de los sistemas, pero en sistemas que usan mawk por defecto, solucionará los problemas de inicio del servidor relacionados con las marcas de tiempo, ya que mawk no admite strftime

<li>Opción de cuenta regresiva -t corregida en stop.sh (gracias a da99Beast, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/76">problema n.° 76</a>)

<li>Se solucionó un problema grave: la instalación de libcurl3 sobre libcurl4 se permitía en algunas configuraciones (como Ubuntu 18.04) y afectaba gravemente a curl (gracias a Goretech ... <li>Se solucionó un problema por el cual se podían crear carpetas vacías en la ubicación incorrecta si start.sh no se ejecutaba desde la carpeta del servidor (gracias a CobraBitYou, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/93">problema n.° 93</a></li>
</ul>
<li>1 de julio de 2021</li>
<ul>
<li>Se cambió de wget a curl porque wget se congela (pero curl funciona)</li>
<li>Se agregó aleatorización al agente de usuario</li>
</ul>
<li>19 de junio de 2021</li>
<ul>
<li>Se corrigieron las marcas de tiempo para que se muestren en cada línea (gracias a murkyl)</li>
<li>Se agregó el comando chmod después de la línea de descompresión para que bedrock_server sea ejecutable para <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/22">Problema n.° 22</a> (gracias, murkyl)</li>
<li>Se fusionó la <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/91">solicitud de extracción n.° 91</a> de starkey-01 para añadir un aviso para un directorio de instalación alternativo. Esto se ha solicitado desde hace tiempo, ¡así que gracias, starkey-01!</li>
<li>Se fusionó la <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/88">solicitud de extracción n.° 88</a>, aclarando las instrucciones para ejecutar el script como usuario no root (¡gracias, sparagi!).</li>
</ul>
<li>23 de mayo de 2021</li>
<ul>
<li>El script fixpermissions.sh ahora muestra las últimas 5 líneas del último archivo de registro para facilitar la resolución de problemas. Si tu servidor no se inicia, este script se encargará de ello con frecuencia; de lo contrario, los registros pueden proporcionar información útil.</li>
</ul>
<li>22 de mayo de 2021</li>
<ul>
<li>Se agregó la configuración de la variable de ruta a cada script para evitar que el servicio no se inicie por no encontrar la ruta correcta.</li>
<li>Vuelve a descargar SetupMinecraft.sh para esta actualización. El script te avisará cada vez que inicies el sistema indicando que no se pudo establecer la variable de ruta sin el nuevo script SetupMinecraft.sh.</li>
<li>Se añadió un agente de usuario a la cadena wget para evitar que la comprobación de actualizaciones falle.</li>
<li>Se añadió una actualización automática a SetupMinecraft.sh si no se ha modificado durante más de 7 días.</li>
<li>Se actualizaron las dependencias de Raspberry Pi.</li>
</ul>
<li>22 de abril de 2021.</li>
<ul>
<li>Se añadió una comprobación de seguridad para evitar la instalación en sistemas operativos de 32 bits (i386 o i686). El servidor dedicado oficial de Bedrock solo se lanzó como binario de 64 bits (x86_64) y los intentos de emulación en 32 bits no han dado resultados.</li>
<li>Se añadió chmod +x bedrock_server a start.sh, ya que las actualizaciones a veces parecen eliminar los permisos de los ejecutables.</li>
<li>Se corrigió la eliminación del contexto del directorio de copia de seguridad antiguo (gracias a murkyl, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/76">problema n.° 76</a>).<li>
</ul>
<li>20 de abril de 2021</li>
<ul>
<li>Comando de ruta completo con /sbin/route para evitar que la comprobación de red interrumpa algunos servidores.</li>
<li>Se añadió una comprobación de seguridad para evitar el uso de la etiqueta de servidor "minecraftbe", que puede interrumpir los scripts.</li>
<li>Se añadió la comprobación de dependencia de libc6, como informaron varios usuarios. Falta libns1.so.1</li>
<li>Se añadieron las dependencias curl y libcurl3 como alternativa para distribuciones antiguas y así evitar errores de libcurl.so faltante.</li>
<li>Se añadió la comprobación de la dependencia libcrypt1.</li>
</ul>
<li>7 de abril de 2021</li>
  <ul>
<li>Si estás actualizando desde una versión anterior, asegúrate de eliminar el archivo SetupMinecraft.sh antiguo y volver a descargar la nueva versión desde cero. Si ves algo como "userxname" en el servicio systemd, estás usando una versión antigua de SetupMinecraft.sh y necesitas descargar la última versión.</li>
<li>Fixpermissions.sh actualizado: ¡puede solucionar problemas con los permisos si los ves!</li>
<li>Se corrigió un error con "userxname" que aparecía en start.sh y no se actualizaba con el nombre de usuario correcto.</li>
<li>Se corrigió un problema que podía activar la autenticación PAM en start.sh.</li>
</ul>
<li>16 de marzo de 2021</li>
<ul>
<li>Se corrigió una línea sudo incompleta en start.sh que generaba un error (¡gracias a /u/zfa de Reddit!).</li>
</ul>
<li>1 de febrero de 2021</li>
<ul>
<li>Se agregó el script de utilidad fixpermissions.sh para tomar posesión de los archivos del servidor de Minecraft manualmente (el servicio de inicio systemd lo hace automáticamente si Lo estás usando)</li>
</ul>
<li>31 de enero de 2021</li>
<ul>
<li>Se añadió .\ delante de las comprobaciones de pantalla -q para evitar que nombres de usuario similares interfieran con la detección de ventanas</li>
<li>El servidor ahora toma la propiedad de los archivos del servidor en cada inicio para evitar muchos problemas y disgustos al restaurar copias de seguridad, mover archivos, etc.</li>
</ul>
<li>20 de diciembre de 2020</li>
<ul>
<li>Se añadió compatibilidad experimental con QEMU para 32 bits (i386, i686), similar a cómo funciona la compatibilidad con ARM</li>
</ul>
<li>18 de diciembre de 2020</li>
<ul>
<li>Se añadió una comprobación de seguridad para evitar que el script se ejecute como root o sudo. Esto provocaría que el script se instalara en la carpeta /root.</li>
<li>Si sabes lo que haces y quieres anularlo, simplemente edita la extracción de SetupMinecraft.sh; de lo contrario, ejecútalo como ./SetupMinecraft.sh normalmente.</li>
<li>Se corrigió un error grave que podía provocar la desaparición de start.sh y stop.sh (gracias, Paul y James). Esto estaba relacionado con la poda de registros y la falta de una ruta de acceso fija. Si descargaste el script SetupMinecraft en los últimos 3 días, actualiza y vuelve a intentarlo aquí. ¡Listo!</li>
</ul>
<li>15 de diciembre de 2020</li>
<ul>
<li>Los paquetes de recursos (incluidos los que habilitan opcionalmente la compatibilidad con RTX) funcionan</li>
<li>Guía disponible en <a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener">https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/</a></li>
<li>Se agregó la rotación automática de copias de seguridad: el servidor conserva las últimas 10 copias de seguridad. Gracias, aghadjip. <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/33">Problema 33</a></li>
<li>Se añadió valid_known_packs a la lista blanca de descompresión para evitar que se sobrescriban los paquetes de recursos. Gracias, kmpoppe. <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/53">Solicitud de extracción 53</a></li>
<li>Crear directorio de registros si no existe. Gracias, omkhar. <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/39">Solicitud de extracción 39</a></li>
</ul>
<li>13 de diciembre de 2020</li>
<ul>
<li>La beta de RTX ahora es compatible siempre y cuando ya no estés en el canal "beta". Cancela tu suscripción a la beta de RTX y cambia a Minecraft normal. RTX ahora está en Minecraft normal.</li>
<li>Se corrigió la compatibilidad con ARM para Raspberry Pi, Tinkerboard y otros. ¡Atención, sigue siendo muy lento en ARM!</li>
<li>Depends.zip actualizado</li>
</ul>
<li>10 de diciembre de 2020</li>
  <ul>
<li>Documentación limpia</li>
<li>Se agregó un aviso indicando que la versión beta RTX del servidor dedicado de Minecraft aún no se ha lanzado. ¡Se añadirá soporte en cuanto esté disponible!</li>
<li>Se añadió un aviso de software alfa para el servidor dedicado Bedrock según el <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/34">número 34</a></li>
</ul>
<li>17 de noviembre de 2020</li>
<ul>
<li>Se corrigió la actualización automática del servidor en start.sh</li>
<li>Minecraft.net había realizado un cambio donde el parámetro "--spider" devolvía un error 503; se eliminó esto para corregir las actualizaciones automáticas</li>
</ul>
<li>24 de julio de 2019</li>
<ul>
<li>Se corrigió la compatibilidad con Raspberry Pi</li>
</ul>
<li>10 de julio de 2019</li>
<ul>
<li>Se corrigió el error de OpenSSL en la versión 1.12 (gracias) ¡Obviador!)</li>
<li>Se corrigió que los puertos no eligieran los valores predeterminados si no se ingresaba nada (¡gracias, sweavo!)</li>
</ul>
<li>2 de julio de 2019</li>
<ul>
<li>Se agregó la dependencia del servidor Bedrock de libcurl4 al script de instalación para evitar que el servidor falle al iniciarse</li>
</ul>
<li>1 de julio de 2019</li>
<ul>
<li>Se agregó compatibilidad con múltiples servidores</li>
<li>Seleccione el nombre de la carpeta y el puerto para el servidor en SetupMinecraft.sh (debe ser único por instancia de servidor)</li>
</ul>
<li>23 de mayo de 2019</li>
<ul>
<li>Se corrigió un error tipográfico en restart.sh donde había un espacio después del comando de detención que impedía que el servidor se cerrara correctamente</li>
<li>Se agregó un tiempo de suspensión de 10 segundos después de un cierre forzado para que el servidor tenga tiempo de cerrarse por completo antes de llamar start.sh</li>
<li>Se corrigió el error del servidor que no se reiniciaba tras un reinicio nocturno programado (relacionado con el error restart.sh)</li>
<li>Se eliminaron algunas rutas directas (por ejemplo, /bin/sleep) que perjudicaban la compatibilidad multiplataforma</li>
</ul>
<li>26 de abril de 2019</li>
<ul>
<li>Se probó el nuevo servidor dedicado Bedrock 1.11.1.2</li>
<li>Se añadió un contador de inicio al servidor en lugar de esperar solo 4 segundos para reducir esperas innecesarias</li>
<li>Se corrigió la compatibilidad con ARM (se requieren 64 bits)</li>
</ul>
<li>18 de abril de 2019</li>
<ul>
<li>Se cambió StopChecks++ a StopChecks=$((StopChecks+1)) para mejorar la portabilidad (gracias, Jason B.)</li>
<li>Se añadió TimeoutStartSec=600 al servidor Para evitar que se cierre si la descarga del servidor tarda más de lo habitual.</li>
</ul>
<li>7 de marzo de 2019</li>
<ul>
<li>Compatibilidad con Armbian añadida</li>
<li>Probado con Tinkerboard</li>
<li>Problema de portabilidad corregido con route vs /sbin/route</li>
</ul>
<li>2 de marzo de 2019</li>
<ul>
<li>Ejecutar el script SetupMinecraft.sh después de la instalación ahora actualiza todos los scripts y reconfigura el servicio minecraftbe</li>
<li>El script ahora funciona en cualquier distribución basada en Debian (Ubuntu, Debian, Raspbian, etc.).<br>
<li>Compatibilidad *muy lenta* añadida con plataformas ARM como Raspberry Pi con emulación QEMU de x86_64</li>
<li>Servicio renombrado a minecraftbe para evitar confusiones con la versión de Java</li>
</ul>
<li>15 de febrero de 2019</li>
<ul>
<li>Las copias de seguridad ahora se comprimen en formato .tar.gz (se guardan en la carpeta de copias de seguridad)</li>
<li>El servicio de inicio espera hasta 20 segundos a que se establezca una conexión a internet para que DHCP pueda recuperar una dirección IP</li>
<li>Se eliminó el tiempo de suspensión innecesario del script stop.sh para que vuelva a funcionar en cuanto se cierra el servidor de Minecraft</li>
</ul>
<li>8 de febrero de 2019</li>
<ul>
<li>Versión inicial</li>
</ul>
</ul>
