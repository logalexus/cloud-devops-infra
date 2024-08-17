from sqlalchemy import Column, String, Integer
from db.database import Base


class Message(Base):
    __tablename__ = "message"

    id = Column(Integer, primary_key=True, unique=True, nullable=False)
    status = Column(String, default="processing")
    answer = Column(String)
    text = Column(String)
