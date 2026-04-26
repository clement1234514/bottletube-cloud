import boto3
import os
from bottle import Bottle, request, template

app = Bottle()

S3_BUCKET = os.getenv("S3_BUCKET", "bottletube-default")

s3 = boto3.client("s3")

@app.get("/")
def index():
    return "<h1>BottleTube läuft</h1><form action='/upload' method='post' enctype='multipart/form-data'><input type='file' name='file'><input type='submit'></form>"

@app.post("/upload")
def upload():
    upload = request.files.get('file')
    if not upload:
        return "Keine Datei hochgeladen"

    filename = upload.filename
    data = upload.file.read()

    s3.put_object(
        Bucket=S3_BUCKET,
        Key=filename,
        Body=data,
        ContentType=upload.content_type
    )

    return f"Upload erfolgreich: {filename}"
