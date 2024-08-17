import models

from db.database import Base, engine


def init():
    Base.metadata.create_all(bind=engine)


if __name__ == "__main__":
    init()
