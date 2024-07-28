--schema.sql

DROP DATABASE IF EXISTS gift-tracker;
CREATE DATABASE gift-tracker;

\c gift-tracker

-- Drop dependent tables

-- Drop main tables
DROP TABLE IF EXISTS users, gifts;


-- Create users table

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name TEXT UNIQUE NOT NULL CHECK (char_length(user_name) > 2 AND char_length(user_name) <= 30),
    password TEXT NOT NULL,
    admin BOOLEAN DEFAULT false,
    verified BOOLEAN DEFAULT false,
    user_banned BOOLEAN NOT NULL DEFAULT false,
    user_premium BOOLEAN NOT NULL DEFAULT false,
    name_first TEXT NOT NULL,
    name_last TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    profile_pic BYTEA,
    user_profile JSONB,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Gifts table
CREATE TABLE gifts (
    gift_id SERIAL PRIMARY KEY,
    item TEXT NOT NULL,
    category TEXT, 
    description TEXT,
    cost NUMERIC(7,2),
    notes TEXT, 
    recipient TEXT,
    date_purchased DATE,
    -- recipient_id INT REFERENCES recipients(recipient_id),
    -- occasion TEXT,    
    -- occasion_id INT REFERENCES occasions(occasion_id) NOT NULL,
    status TEXT CHECK (status IN ('considering', 'purchased', 'sent')) DEFAULT 'considering'
);



-- Adding indexes to frequently queried columns on a recommendation
-- CREATE INDEX idx_users_user_name ON users(user_name);
-- CREATE INDEX idx_users_email ON users(email);
-- CREATE INDEX idx_recipients_name ON recipients(name_first, name_last);
-- CREATE INDEX idx_gifts_recipient ON gifts(recipient_id);
-- CREATE INDEX idx_gifts_occasion ON gifts(occasion_id);

-- FROM recipients;