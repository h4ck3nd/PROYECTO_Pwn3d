# Obtener el nombre de usuario actual
$user = $env:USERNAME

# Construir ruta completa
$targetPath = "C:\Users\$user\eclipse-workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\imgProfile"

# Crear carpeta si no existe
if (-not (Test-Path -Path $targetPath)) {
    New-Item -ItemType Directory -Path $targetPath -Force
    Write-Host "Carpeta creada en: $targetPath"
} else {
    Write-Host "La carpeta ya existe: $targetPath"
}

# URL directa de descarga de la imagen en Google Drive
$imageUrl = "https://drive.google.com/uc?export=download&id=16GIr4Y0Z1oDKEaUcCGe902sQ8C5z2OQC"

# Ruta local donde guardar la imagen
$outputFile = Join-Path $targetPath "default.png"

# Descargar la imagen y guardar
Invoke-WebRequest -Uri $imageUrl -OutFile $outputFile

Write-Host "Imagen descargada y guardada como $outputFile"
