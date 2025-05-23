# 314_Project

Event Managing System

## Install instructions.

1. Must have Node.js installed. (https://nodejs.org/en)
2. Ensure that path to Node.js is in your system PATH.
3. Open project directory in the terminal and use the command 'npm install'.
4. Must then install PosgreSQL and pgadmin 4. (https://www.postgresql.org/download/)

(Note: These instructions are for Windows)

## Event Management Database Setup

Steps to setup Event Management DB

### Setup Instructions

1. Open pgadmin4
2. Connect to PostgreSQL server
3. Right-click on "Databases" folder and select "Create" then "Database..."
4. Name database "event_management" and save
5. Right click on the newly created database and open "Query Tool"
6. In Query Tool find "Open File" and click to open file (crtl+o also will work)
7. Navigate to the database folder. PATH: ./src/database
8. Open "schema.sql"
9. Run script with "Execute" (looks like play button) or F5
10. When completed, verify by checking if tables exist under; Schemas -> public -> Tables

### Notes

To run the sample data:

1. Select your "event_management" database
2. Right-click on it and select "Query Tool"
3. Open the "sample_data.sql" file and click Execute or use F5 to run
4. Repeat with "clear_sample_data.sql" to remove the sample data
