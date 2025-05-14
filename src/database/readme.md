# Event Management Database Setup

Steps to setup Event Management DB

## Setup Instructions
1. Open pgadmin4
2. Connect to PostgreSQL server
3. Right-click on "Databases" folder and select "Create" then "Database..."
4. Name database "event_management" and save
5. Right click on the newly created database and open "Query Tool"
6. In Query Tool find "Open File" and click to open file (crtl+o also will work)
7. Open "event_management.sql"
8. Run script with "Execute" (looks like play button) or F5
9. When completed, verify by checking if tables exist under; Schemas -> public -> Tables


## Notes
There is some sample data I will add if you would like to verify it all works, to run the sample data:
1. Select your "event_management" database
2. Right-click on it and select "Query Tool"
3. Open the "sample_data.sql" file and click Execute or use F5 to run
4. Repeat with "clear_sample_data.sql" to remove the sample data
