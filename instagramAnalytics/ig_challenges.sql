-- Find the 5 oldest users of the Instagram from the database provided
select  DISTINCT username,created_at from users
order by created_at asc limit 5;

-- Find the users who have never posted a single photo on Instagram to send them promotional mail
SELECT u.id as user_id,u.username FROM users u
LEFT JOIN photos ph ON u.id = ph.user_id 
WHERE ph.user_id is null;

-- What day of the week do most users register on? Provide insights on when to schedule an ad campaign
SELECT DAYNAME (created_At) as WeekDay,COUNT(*)
FROM users 
GROUP BY DAYNAME(created_at)
ORDER BY COUNT(*) DESC limit 1;

-- identify and suggest the top 5 most commonly used hashtags on the platform
SELECT u.* FROM users u
where u.id not in (select p.user_id from photos p);
SELECT tag_name FROM tags
ORDER BY tag_name DESC
LIMIT 5;

-- The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
-- Your Task: Identify the winner of the contest and provide their details to the team
SELECT photos.id,username,photos.image_url as photo_link,COUNT(*) AS total
FROM photos
INNER JOIN likes ON likes.photo_id = photos.id
INNER JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC limit 1;



-- 
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2) as average_post;

-- total numbers of users who have posted at least one time 
SELECT COUNT(DISTINCT(users.id)) AS total_number_of_users_with_posts
FROM users
JOIN photos ON users.id = photos.user_id;

