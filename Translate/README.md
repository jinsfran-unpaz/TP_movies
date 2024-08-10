# Translate

Se recomienda crear un entorno virtual de python, por ejemplo:
```
python -m venv .venv
```
Activar el entorno e instalar las librerías necesarias
```
pip install -r requirements.txt
```

Crear un archivo .env con las variables de entorno que usa el código para conectarse a la base de datos y para consumir el servicio de traducción
```
KEY = 
ENDPOINT = 
LOCATION = 
PATHL = 
SERVER = 
DATABASE = 
USER = 
PASSWORD = 
```
Para realizar la traducción, primero modificar la base con el script [alter.sql](alter.sql)

Y luego se puede ejecutar:
```
python .\translate.py
```