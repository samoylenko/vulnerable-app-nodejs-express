from sqlalchemy import create_engine

# Establish a connection (replace these placeholders with actual values)
db_connection = create_engine('mysql+pymysql://your_username:your_password@localhost/your_database')

# Prepare the query using parameterized inputs
query = "SELECT * FROM users WHERE username=:username"
cursor = db_connection.execute(query, {"username": username})

# Fetch results and convert to list of dictionaries
results = cursor.fetchall()

# Close connection and cursor (if necessary)
cursor.close()
db_connection.dispose()