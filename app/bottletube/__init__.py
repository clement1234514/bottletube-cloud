from bottle import Bottle, request, template

app = Bottle()

@app.get("/")
def index():
    return "BottleTube läuft!"

@app.post("/upload")
def upload():
    upload = request.files.get('file')
    if not upload:
        return "Keine Datei hochgeladen"
    return "Upload erfolgreich"
