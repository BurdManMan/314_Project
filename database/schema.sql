CREATE TABLE site_user (
    site_user_id SERIAL PRIMARY KEY,
    account_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(20) NOT NULL CHECK (account_type IN ('Customer', 'Organiser')),
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE customer (
    user_id SERIAL PRIMARY KEY,
    site_user_id INTEGER NOT NULL REFERENCES site_user(site_user_id),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE organiser (
    organiser_id SERIAL PRIMARY KEY,  
    site_user_id INTEGER NOT NULL REFERENCES site_user(site_user_id),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE event (
    event_id SERIAL PRIMARY KEY,
    organiser_id INTEGER NOT NULL REFERENCES organiser(organiser_id),
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    event_date TIMESTAMP NOT NULL,
    category VARCHAR(50) CHECK(category IN ('Conference', 'Music', 'Networking', 'Workshop', 'Seminar', 'Fundraiser', 'Party', 'Theatre', 'Sports', 'Other')),
    description TEXT,
    ticket_total INTEGER NOT NULL CHECK (ticket_total >= 0),
    tickets_available INTEGER NOT NULL CHECK (tickets_available >= 0)
);

CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES customer(user_id),
    event_id INTEGER NOT NULL REFERENCES event(event_id),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Approved', 'Rejected')),
    details TEXT
);

CREATE TABLE ticket (
    ticket_id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES event(event_id),
    registration_id INTEGER NOT NULL REFERENCES registration(registration_id),
    ticket_type VARCHAR(20) NOT NULL CHECK (ticket_type IN ('Standard', 'VIP')),
    seat VARCHAR(20),
    details TEXT,
    price NUMERIC(10, 2) NOT NULL
);