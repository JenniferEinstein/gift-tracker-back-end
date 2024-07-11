DROP DATABASE IF EXISTS gift-tracker;
CREATE DATABASE gift-tracker;

\c gift-tracker

-- Drop dependent tables

-- Drop main tables


CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name TEXT UNIQUE NOT NULL CHECK (char_length(user_name) > 2 AND char_length(user_name) <= 30),
    password TEXT NOT NULL
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

-- Recipients table with nullable birthday
CREATE TABLE recipients (
    recipient_id SERIAL PRIMARY KEY,
    name_first TEXT NOT NULL,
    name_last TEXT,
    nickname TEXT,
    relationship_id INT REFERENCES relationships(relationship_id) NOT NULL,
    birthday DATE CHECK (birthday > '1910-01-01'),
    birthdate DATE, 
    -- birth_year smallint (birth_year >1910),
    -- current_age smallint (current_age < 130), 
    notes TEXT,
    archived BOOLEAN DEFAULT false,
);

-- Function to calculate age
CREATE OR REPLACE FUNCTION calculate_age(birth_date DATE) RETURNS INT AS $$
BEGIN
    RETURN DATE_PART('year', AGE(birth_date));
END;
$$ LANGUAGE plpgsql;

-- View to calculate age dynamically
CREATE OR REPLACE VIEW recipients_with_age AS
SELECT 
    recipient_id,
    name_first,
    name_last,
    nickname,
    relationship_id,
    birthday,
    notes,
    archived,
    CASE 
        WHEN birthday IS NOT NULL THEN calculate_age(birthday)
        ELSE NULL
    END AS age
FROM recipients;

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

-- Gifts table
CREATE TABLE gifts (
    gift_id SERIAL PRIMARY KEY,
    item TEXT NOT NULL,
    category TEXT, 
    description TEXT,
    notes TEXT, 
    recipient_id INT REFERENCES recipients(recipient_id),
    occasion TEXT,    
    occasion_id INT REFERENCES occasions(occasion_id) NOT NULL,
    status TEXT CHECK (status IN ('considering', 'purchased', 'sent')) DEFAULT 'considering'
);


-- Function to calculate age
CREATE OR REPLACE FUNCTION calculate_age(birth_date DATE, birth_year_known BOOLEAN) RETURNS INT AS $$
BEGIN
    IF birth_year_known THEN
        RETURN DATE_PART('year', AGE(birth_date));
    ELSE
        RETURN NULL; -- IS THIS WHAT I WANT?
    END IF;
END;
$$ LANGUAGE plpgsql;


-- View to calculate age dynamically
CREATE OR REPLACE VIEW recipients_with_age AS
SELECT 
    recipient_id,
    name_first,
    name_last,
    nickname,
    relationship_id,
    birthday,
    birth_year_known,
    notes,
    archived,
    CASE 
        WHEN birthday IS NOT NULL AND birth_year_known THEN calculate_age(birthday, birth_year_known)
        ELSE NULL
    END AS age

-- Adding indexes to frequently queried columns on a recommendation
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_recipients_name ON recipients(name_first, name_last);
CREATE INDEX idx_gifts_recipient ON gifts(recipient_id);
CREATE INDEX idx_gifts_occasion ON gifts(occasion_id);

FROM recipients;