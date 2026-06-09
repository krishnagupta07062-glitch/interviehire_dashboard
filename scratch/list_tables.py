import psycopg2

try:
    conn = psycopg2.connect("postgresql://postgres:keepitsimple@localhost:5432/hiring_dashboard")
    cur = conn.cursor()
    cur.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public'
    """)
    tables = cur.fetchall()
    print("Tables in database:")
    for table in tables:
        print("-", table[0])
    cur.close()
    conn.close()
except Exception as e:
    print("Error:", e)
