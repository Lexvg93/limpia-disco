#!/bin/bash

# Ruta del disco externo (ajústalo según tu volumen)
DISCO="/Volumes/TuDiscoExterno"

echo "Monitoreando $DISCO para limpiar archivos '._*'..."
echo "Presiona Ctrl + C para detener el script."

# Función de limpieza
limpiar_dot_clean() {
    echo "$(date '+%H:%M:%S') - Ejecutando dot_clean en $DISCO ..."
    dot_clean -m "$DISCO"
    find "$DISCO" -name "._*" -type f -delete
    echo "$(date '+%H:%M:%S') - Archivos '._*' eliminados."
}

# Limpieza inicial
limpiar_dot_clean

# Manejo de Ctrl + C para detener el script limpiamente
trap "echo 'Script detenido por el usuario'; exit 0" SIGINT

# Monitoreo continuo con fswatch
fswatch -o "$DISCO" | while read f
do
    limpiar_dot_clean
done
