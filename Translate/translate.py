""" Este script se encarga de traducir los nombres de las categorias de ingles a español """
import os
import uuid
import requests
from dotenv import load_dotenv
import pyodbc

load_dotenv()

key = os.getenv("KEY")
endpoint = os.getenv("ENDPOINT")
location = os.getenv("LOCATION")
path = os.getenv("PATHL")
constructed_url = endpoint + path
params = {
    'api-version': '3.0',
    'from': 'en',
    'to': 'es'
}
headers = {
    'Ocp-Apim-Subscription-Key': key,
    'Ocp-Apim-Subscription-Region': location,
    'Content-type': 'application/json',
    'X-ClientTraceId': str(uuid.uuid4())
}

conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+os.getenv("SERVER")+
                      ';DATABASE='+os.getenv("DATABASE")+';UID='+os.getenv("USER")+
                      ';PWD='+ os.getenv("PASSWORD"))

cursor = conn.cursor()
cursor.execute('SELECT categoria_id, categoria_nombre, categoria_nombre_es FROM categoria')

translations = []
for row in cursor:
    print(row)
    body = [{ 'text': 'movie genre: ' + row[1]}]
    request = requests.post(constructed_url, params=params, headers=headers, json=body, timeout=5)
    response = request.json()
    translated_text = response[0]['translations'][0]['text']
    translated_text = translated_text.split(": ")[1]
    print(translated_text)
    translations.append((translated_text, row[0]))
for translation in translations:
    cursor.execute("UPDATE categoria SET categoria_nombre_es = ? WHERE categoria_id = ?",
                   translation[0], translation[1])
conn.commit()
conn.close()
