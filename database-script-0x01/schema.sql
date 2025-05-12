-- Create tables using PostgreSQL DDL

-- Install extension for uuid generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- Create enum types
CREATE TYPE role_type AS ENUM ("guest", "host", "admin");
CREATE TYPE status_type AS ENUM ("pending", "confirmed", "canceled")
CREATE TYPE payment_type AS ENUM ("credit_card", "paypal", "stripe")

-- Define schema
CREATE TABLE IF NOT EXISTS User (
    user_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() INDEX,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL INDEX,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR NULL,
    role role_type NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS Property (
    property_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() INDEX,
    host_id FOREIGN KEY REFERENCES User.user_id,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    price_per_night DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP()
);

-- Postgres trigger for ON UPDATE
CREATE OR REPLACE FUNCTION update_updated_at_column
RETURNS TRIGGER AS $$
BEGIN
    IF row(NEW.*) IS DISTINCT FROM row(OLD.*) THEN
        NEW.updated_at = now();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_property_updated_at
BEFORE UPDATE ON Property
FOR EACH row
EXECUTE FUNCTION update_updated_at_column;

CREATE TABLE IF NOT EXISTS Booking (
    booking_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() INDEX,
    property_id FOREIGN KEY REFERENCES Property.property_id,
    user_id FOREIGN KEY REFERENCES User.user_id,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status status_type NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Payment (
    payment_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() INDEX,
    booking_id FOREIGN KEY REFERENCES Booking.booking_id INDEX,
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_type NOT NULL
);

CREATE TABLE IF NOT EXISTS Review (
    review_id uuid PRIMARY KEY DEFAULT CURRENT_TIMESTAMP INDEX,
    property_id FOREIGN KEY REFERENCES Property.property_id INDEX,
    user_id FOREIGN KEY REFERENCES User.user_id,
    rating INTEGER CHECK rating >= 1 AND rating <= 5 NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Message (
    message_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() INDEX,
    sender_id FOREIGN KEY REFERENCES User.user_id,
    recipient_id FOREIGN KEY REFERENCES User.user_id,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP CURRENT_TIMESTAMP
);
