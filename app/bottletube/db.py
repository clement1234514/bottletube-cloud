import boto3
import json
import psycopg2
import os

def get_db_credentials():
    secret_name = os.getenv("DB_SECRET_NAME", "bottletube-db-credentials")
    region = os.getenv("AWS_REGION", "eu-central-1")

    client = boto3.client("secretsmanager", region_name=region)
    secret = client.get_secret_value(SecretId=secret_name)
    creds = json.loads(secret["SecretString"])
    return creds

def get_connection():
    creds = get_db_credentials()

    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        database="postgres",
        user=creds["username"],
        password=creds["password"]
    )
    return conn
