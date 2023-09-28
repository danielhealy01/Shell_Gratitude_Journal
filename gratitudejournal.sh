#!/bin/bash

source .env

echo What are you grateful for today?

SQL_STATEMENT_SET_TABLE="CREATE TABLE IF NOT EXISTS gratitudeTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT,
    gratitude TEXT
);"

sqlite3 -line "$DB_NAME" <<< "$SQL_STATEMENT_SET_TABLE"

read newEntry

SQL_INSERT_QUERY="INSERT INTO gratitudeTable (date, gratitude) VALUES (date('now', 'localtime'), '$newEntry');"

echo entering into db $newEntry

sqlite3 -line "$DB_NAME" <<< "$SQL_INSERT_QUERY"

echo "Show past entries? (y/n)"

read getEntriesBool

if [ "$getEntriesBool" = "y" ]; then
    SQL_QUERY="SELECT * FROM gratitudeTable;"
    query_result=$(sqlite3 -header "$DB_NAME" "$SQL_QUERY")
    echo "$query_result"
    exit 0

elif [ "$getEntriesBool" = "n" ]; then
    exit 0

else
    echo Error. Exiting.
    exit 1
fi