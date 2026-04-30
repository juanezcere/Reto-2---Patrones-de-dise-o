from fastapi.testclient import TestClient
from main import app
from src.infrastructure.config import init_db

client = TestClient(app)

def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the Medellin Artist Performance Coordinator API"}

def test_list_categories():
    response = client.get("/categories")
    assert response.status_code == 200
    assert "sound" in response.json()
    assert "transport" in response.json()

def test_create_artist_api():
    response = client.post("/artists", json={"name": "Prueba", "email": "test@medellin.co"})
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "Prueba"
    assert "id" in data
