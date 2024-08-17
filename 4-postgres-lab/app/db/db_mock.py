import os
import random
import psycopg2
import time

from concurrent.futures import ThreadPoolExecutor
from db.db_init import init
from faker import Faker

fake = Faker()

DATABASE_URL = os.getenv(
    "DATABASE_URL", "postgresql://user:pass@localhost:5432/db")


TOTAL_RECORDS = 1000000
MAX_THREADS = 10
BATCH_SIZE = 15


def timing_decorator(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        print(
            f"Function {func.__name__} took {end_time - start_time} seconds to run.")
        return result
    return wrapper


def generate_records(batch_size):
    records = []
    for _ in range(batch_size):
        status = random.choice(["success", "processing"])
        answer = fake.sentence()
        text = fake.text()
        records.append((status, answer, text))
    return records


def insert_rows(count):
    conn = psycopg2.connect(DATABASE_URL)
    cursor = conn.cursor()

    for _ in range(count // BATCH_SIZE):
        records = generate_records(BATCH_SIZE)
        insert_query = "INSERT INTO message (status, answer, text) VALUES %s"
        psycopg2.extras.execute_values(cursor, insert_query, records)

        conn.commit()

    cursor.close()
    conn.close()


@timing_decorator
def main():

    init()

    with ThreadPoolExecutor(max_workers=MAX_THREADS) as executor:
        futures = [executor.submit(
            insert_rows, TOTAL_RECORDS // MAX_THREADS) for i in range(MAX_THREADS)]

        for future in futures:
            future.result()

    print("All data inserted.")


if __name__ == "__main__":
    main()
