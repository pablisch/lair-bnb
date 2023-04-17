TRUNCATE TABLE users, spaces, bookings RESTART IDENTITY; 

INSERT INTO users (username, email, password) VALUES 
('Amber', 'amber@example.com', 'Password1'),
('Billy', 'billy@example.com', 'Password2'),
('Caleb', 'caleb@example.com', 'Password3'),
('Dennis', 'dennis@example.com', 'Password4'),
('Emily', 'emily@example.com', 'Password5'),
('Faizah', 'faizah@example.com', 'Password6'),
('Greta', 'greta@example.com', 'Password7'),
('Hande', 'hande@example.com', 'Password8')
;

INSERT INTO spaces (name, description, price, available_from, available_to, user_id) VALUES 
('Bag End', 'Charming and cosy with a quirky front door', 70, '2023-05-01', '2023-05-15', 1),
('Winterfell', 'Plenty of rustic charm, open countryside and extra firewood available.', 120, '2023-05-03', '2023-05-17', 2),
('Moria', 'Cavernous dwelling with plenty to explore and a huge open fire.', 180, '2023-05-06', '2023-05-20', 3),
('The Burrow', 'Charming and full of character. Sleeping room for many guests', 95, '2023-05-05', '2023-05-19', 1),
('Orthanc', 'Stunning white tower among a lively woodland setting.', 200, '2023-05-02', '2023-05-16', 5)
;

INSERT INTO bookings (booking_date, status, space_id, guest_id) VALUES 
('2023-05-10', true, 1, 2),
('2023-05-11', true, 2, 7),
('2023-05-07', true, 3, 1),
('2023-05-09', true, 4, 6),
('2023-05-10', true, 2, 7),
('2023-05-11', true, 1, 3),
('2023-05-13', false, 5, 1),
('2023-05-13', false, 5, 8)
;