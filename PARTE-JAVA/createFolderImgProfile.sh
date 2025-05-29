#!/bin/bash

# Ajusta esta variable con la ruta base de Tomcat donde está desplegado ROOT
TOMCAT_ROOT_WORK_DIR="/var/lib/tomcat9/work/Catalina/localhost/ROOT"

# Ruta final donde crear imgProfile
TARGET_PATH="$TOMCAT_ROOT_WORK_DIR/imgProfile"

# Crear carpeta si no existe
if [ ! -d "$TARGET_PATH" ]; then
  mkdir -p "$TARGET_PATH"
  echo "Carpeta creada en: $TARGET_PATH"
else
  echo "La carpeta ya existe: $TARGET_PATH"
fi

# URL directa para descargar la imagen (formato descarga directa)
IMAGE_URL="https://drive.google.com/uc?export=download&id=16GIr4Y0Z1oDKEaUcCGe902sQ8C5z2OQC"

# Archivo destino
OUTPUT_FILE="$TARGET_PATH/default.png"

# Descargar la imagen
if command -v curl >/dev/null 2>&1; then
  curl -L "$IMAGE_URL" -o "$OUTPUT_FILE"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$OUTPUT_FILE" "$IMAGE_URL"
else
  echo "Error: ni curl ni wget están instalados."
  exit 1
fi

echo "Imagen descargada y guardada como $OUTPUT_FILE"
