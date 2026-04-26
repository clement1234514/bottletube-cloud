import boto3
import os
from bottle import Bottle, request, template
from .db import get_connection
from .init_db import init_db

app = Bottle()

S3_BUCKET = os.getenv("S3_BUCKET")
REGION = os.getenv("AWS_REGION", "eu-central-1")

s3 = boto3.client("s3")

# DB initialisieren
init_db()

@app.get("/")
def index():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT filename, s3_url FROM images ORDER BY uploaded_at DESC;")
    images = cur.fetchall()
    cur.close()
    conn.close()

    html = "<h1>BottleTube</h1>"
    html += "<form action='/upload' method='post' enctype='multipart/form-data'>"
    html += "<input type='file' name='file'><input type='submit'></form><hr>"

    for filename, url in images:
        html += f"<p>{filename}</p><img src='{url}' width='300'><hr>"

    return html

@app.post("/upload")
def upload():
    upload = request.files.get('file')
    if not upload:
        return "Keine Datei hochgeladen"

    filename = upload.filename
    data = upload.file.read()

    # Upload nach S3
    s3.put_object(
        Bucket=S3_BUCKET,
        Key=filename,
        Body=data,
        ContentType=upload.content_type
    )

    s3_url = f"https://{S3_BUCKET}.s3.{REGION}.amazonaws.com/{filename}"

    # In DB speichern
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO images (filename, s3_url) VALUES (%s, %s)",
        (filename, s3_url)
    )
    conn.commit()
    cur.close()
    conn.close()

    return f"Upload erfolgreich: <a href='/'>{filename}</a>"
