from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI
from src.infrastructure.adapters.api.routers import router
from src.infrastructure.config import init_db

app = FastAPI(title="Medellin Artist Coordinator")

init_db()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router)


@app.get("/")
def read_root():
    return {"message": "Welcome to the Medellin Artist Performance Coordinator API"}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
