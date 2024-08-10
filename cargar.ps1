# Recorro los archivos .sql de la carpeta actual y los cargo en la base de datos usando sqlcmd
# Uso: .\cargar.ps1

# Cargo variables de .env
$env = Get-Content .env
$server = $env[0].Split('=')[1]
$usuario = $env[1].Split('=')[1]
$clave = $env[2].Split('=')[1]

# Obtengo los archivos .sql de la carpeta actual en orden alfabético
$files = Get-ChildItem -Path . -Filter *.sql | Sort-Object Name

# Recorro los archivos
foreach ($file in $files) {
    Write-Host "Cargando $file"
    sqlcmd -S $server -i $file -U $usuario -P $clave
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error al cargar $file"
        exit
    }
}
