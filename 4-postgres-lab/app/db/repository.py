from typing import List
from sqlalchemy.orm import Session
from db.models import Message


def add_message(db: Session, message: Message) -> Message:
    db.add(message)
    db.commit()
    db.refresh(message)
    return message


def delete_all_messages(db: Session):
    db.query(Message).delete()


def get_message_by_id(db: Session, id: str) -> Message:
    return db.query(Message).filter(Message.id == id).first()


def get_message_by_status(db: Session, status: str) -> List[Message]:
    return db.query(Message).filter(Message.status == status).all()
