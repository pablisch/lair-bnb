TRUNCATE TABLE users, spaces, bookings RESTART IDENTITY;

INSERT INTO users (username, email, password) VALUES
('Bilbo', 'hobbit@example.com', 'Password1'),
('Sauron', 'lostmyring@example.com', 'Password2'),
('Gollum', 'cavedweller@example.com', 'Password3'),
('Aragorn', 'kingofmen@example.com', 'Password4'),
('Treebeard', 'herdtrees@example.com', 'Password5'),
('Smaug', 'ieatgold@example.com', 'Password6'),
('Arwen', 'areosmith_fan@example.com', 'Password7'),
('Elrond', 'elf_agent@example.com', 'Password8')
;

INSERT INTO spaces (name, description, price, available_from, available_to, user_id) VALUES
('Bag End', 'Charming and cosy with a quirky front door', 70, '2023-05-01', '2023-05-15', 1),
('Barad-dûr', 'Plenty of rustic charm, open countryside and an all new menu!', 120, '2023-05-03', '2023-05-17', 2),
('Moria', 'Cavernous dwelling with plenty to explore and a huge open fire.', 180, '2023-05-06', '2023-05-20', 3),
('Dead Marshes', 'Charming and full of character. Sleeping room for many guests', 95, '2023-05-05', '2023-05-19', 1),
('Orthanc', 'Stunning white tower among a lively woodland setting.', 200, '2023-05-02', '2023-05-16', 5),
('The Weathertop', 'A rustic and historic watchtower from the Third Age complete with panoramic views.', 300, '2023-05-03', '2023-05-17', 2)
;

INSERT INTO bookings (booking_date, status, space_id, guest_id) VALUES
('2023-05-10', 'available', 1, 2),
('2023-05-11', 'available', 2, 7),
('2023-05-07', 'confirmed', 3, 1),
('2023-05-22', 'confirmed', 3, 1),
('2023-05-07', 'confirmed', 4, 1),
('2023-05-07', 'pending', 2, 1),
('2023-05-09', 'confirmed', 4, 1),
('2023-05-10', 'pending', 2, 1),
('2023-05-11', 'confirmed', 1, 3),
('2023-05-13', 'denied', 5, 1),
('2023-05-15', 'denied', 5, 1),
('2023-05-13', 'denied', 4, 1),
('2023-05-14', 'denied', 5, 1)
;
