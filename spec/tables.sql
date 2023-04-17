-- Delete tables if they already exist to create from scratch
DROP TABLE IF EXISTS users, spaces, bookings; 

-- Create the first table.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text, 
  email text,
  password varchar
);

-- Create the second table.
CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price numeric,
  available_from date,
  available_to date,
  user_id int,
  constraint fk_user foreign key(user_id) references users(id) on delete cascade
);

-- Create the third table.
CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  booking_date date,
  confirmed text,
  space_id int,
  guest_id int,
  constraint fk_space foreign key(space_id) references spaces(id) on delete cascade,
  constraint fk_guest foreign key(guest_id) references users(id) on delete cascade
);
