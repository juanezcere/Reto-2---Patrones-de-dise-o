from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from src.infrastructure.adapters.db.models import Base

class DatabaseSingleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(DatabaseSingleton, cls).__new__(cls)
            cls._instance.engine = create_engine(
                "sqlite:///./medellin_artists.db", 
                connect_args={"check_same_thread": False}
            )
            cls._instance.SessionLocal = sessionmaker(
                autocommit=False, autoflush=False, bind=cls._instance.engine
            )
        return cls._instance

def init_db():
    db = DatabaseSingleton()
    Base.metadata.create_all(bind=db.engine)

def get_db():
    db = DatabaseSingleton()
    session = db.SessionLocal()
    try:
        yield session
    finally:
        session.close()
