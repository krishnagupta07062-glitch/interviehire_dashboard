import os
import psycopg2
from dotenv import load_dotenv

# Load backend environment variables
dotenv_path = os.path.join(os.path.dirname(__file__), '..', 'backend', '.env')
load_dotenv(dotenv_path)

db_url = os.getenv("DATABASE_URL")
print(f"Connecting to database: {db_url}")

conn = psycopg2.connect(db_url)
cursor = conn.cursor()

# IDs to delete
ids_to_delete = [
    '80f34fcf-a19a-4956-8beb-e6edf67225e5', # Data Analyst
    '7944b56d-e880-45c3-8a8f-3f2efe24b20d', # Duplicate Marcus Thorne
    '46e63fed-c782-400e-b7b3-ab106861d641', # Duplicate Marcus Thorne
    'd7c5aace-d1c7-4090-9e3d-af391778d384', # Duplicate Elena Rostova
]

print(f"Deleting candidates with IDs: {ids_to_delete}")
cursor.execute("DELETE FROM applicants WHERE id IN %s;", (tuple(ids_to_delete),))
print(f"Deleted {cursor.rowcount} row(s).")

# Commit changes
conn.commit()

# Re-query all applicants for JobId 8a24d8e3-0837-4f99-9c68-0d5dceb6ff49 to verify
print("\n--- Verifying Candidates for JobId 8a24d8e3-0837-4f99-9c68-0d5dceb6ff49 ---")
cursor.execute("""
    SELECT id, name, email, created_at 
    FROM applicants 
    WHERE job_id = '8a24d8e3-0837-4f99-9c68-0d5dceb6ff49';
""")
rows = cursor.fetchall()
for r in rows:
    print(f"ID: {r[0]}, Name: {r[1]}, Email: {r[2]}, CreatedAt: {r[3]}")

cursor.close()
conn.close()
