INSERT INTO users (user_name, password, admin, verified, user_banned, user_premium, name_first, name_last, email, profile_pic, user_profile, date_created)
VALUES
 -- User 1
    ('PepGiraffe', 'password', true, true, false, false, "Jennifer", "Einstein", "pepgiraffe@gmail.com", NULL,  NULL, '2024-07-07'),
 -- User 2
    ('JamStone', 'password', false, false, false, false, "Jamie", "Stone", "jennifereinstein@pursuit.org", NULL,  NULL, '2024-07-20');
  

INSERT INTO gifts(item, category, description, cost, notes, recipient, date_purchased, status)
VALUES
( "place setting", "housewares", "nautical themed kate spade dishes", 72.50, "Got this off their registry", "Tod and Amanda", 2015-08-08, "sent"),
("Strawberry Shortcake Doll", "toy", "12 inch plush from Target", 15.00, "She loved it!", "Ellery", 2022-07-07, "sent")



-- INSERT INTO recipients (name_first, name_last, nickname, relationship_id, relationships, birthday, notes, archived)
-- VALUES
