import db.repository as repository

from db.database import SessionLocal
from fastapi import FastAPI

app = FastAPI()


@app.get("/messages/")
async def get_message(id: str = 0):
    with SessionLocal() as db:
        message = repository.get_message_by_id(db, id)
    return message


@app.get("/messages_status/")
async def get_message_with_status(status: str = "success"):
    with SessionLocal() as db:
        messages = repository.get_message_by_status(db, status)
    return messages[:1000]


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
