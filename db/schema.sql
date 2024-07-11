DROP DATABASE IF EXISTS gift-tracker;
CREATE DATABASE gift-tracker;

\c gift-tracker

-- Drop dependent tables

-- Drop main tables


CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL DEFAULT 'Username' CHECK (char_length(username) > 2 AND char_length(username) <= 30),
    password VARCHAR(30) NOT NULL DEFAULT '00000000' CHECK (password ~ '^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,}$'),
    admin BOOLEAN DEFAULT false,
    verified BOOLEAN DEFAULT false,
    user_banned BOOLEAN NOT NULL DEFAULT false,
    user_premium BOOLEAN NOT NULL DEFAULT false,
    name_first TEXT NOT NULL,
    name_last TEXT NOT NULL DEFAULT,
    email TEXT UNIQUE NOT NULL DEFAULT,
    -- profile_pic ,
    user_profile JSON,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE relationships (
    relationship_id SERIAL PRIMARY KEY,
    relationship TEXT UNIQUE NOT NULL
);

-- Insert predefined relationships
INSERT INTO relationships (relationship) VALUES 
('child'), 
('grandchild'), 
('niece/nephew'), 
('grandparent'), 
('sibling'), 
('parent'), 
('friend'), 
('spouse'), 
('partner'),
('coworker'), 
('other');


CREATE TABLE recipients (
    recipient_id SERIAL PRIMARY KEY,
    name_first TEXT NOT NULL,
    name_last TEXT,
    nickname TEXT,
    relationship_id INT REFERENCES relationships(relationship_id) NOT NULL,
    birthday DATE,
    birthdate DATE,
    notes TEXT,
    archived BOOLEAN DEFAULT false,

);

-- Create the occasions table
CREATE TABLE occasions (
    occasion_id SERIAL PRIMARY KEY,
    occasion TEXT UNIQUE NOT NULL
);

-- Insert predefined occasions
INSERT INTO occasions (occasion) VALUES 
('birthday'), 
('Christmas'), 
('Channukah'), 
('Bar/Bat Mitzvah'), 
('christening'), 
('birth'), 
('wedding'), 
('anniversary'), 
('Mothers Day'), 
('Fathers Day'), 
('wedding'), 
('souvenir'), 
('just because'), 
('get well'), 
('sympathy'), 
('other');


CREATE TABLE gifts (
    gift_id SERIAL PRIMARY KEY,
    item TEXT NOT NULL,
    category TEXT, 
    description TEXT,
    notes TEXT, 
    recipient_id INT REFERENCES recipients(recipient_id),
    occasion TEXT,    occasion_id INT REFERENCES occasions(occasion_id) NOT NULL    

);