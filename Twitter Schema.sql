.mode box
.nullvalue NULL
-- create tables and insert values here
  
--User table
CREATE TABLE User(
  userId INTEGER PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL DEFAULT 'qwerty123',
  firstName TEXT NOT NULL,
  middleName TEXT DEFAULT NULL,
  lastName TEXT NOT NULL,
  nationality TEXT NOT NULL DEFAULT 'INDIAN',
  date_of_birth TEXT NOT NULL DEFAULT '1985-01-31',
  profilePicture BLOB DEFAULT NULL,
  bio TEXT DEFAULT NULL,
  is_verified INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT '2001-01-01 23:59:59'
);

Insert into User (username, email, firstName, lastName) Values
  ('vigynesh','vb@gmail.com','Vigynesh','Bhatt'),
  ('aarohi','ab@gmail.com','Aarohi','Bhatt'),
  ('atul','akb@gmail.com','Atul','Bhatt'),
  ('shubhra','sb@gmail.com','Shubhra','Bhatt'),
  ('chetan','cj@gmail.com','Chetan','Joshi'),
  ('kethura','kv@gmail.com','Kethura','Venammala'),
  ('emma','es@gmail.com','Emma','Steimle'),
  ('max','mk@gmail.com','Max','Kloepfer'),
  ('brian','bb@gmail.com','Brian','Byrd'),
  ('brett','bd@gmail.com','Brett','Decker'),
  ('nancy','nf@gmail.com','Nancy','Fulda'),
  ('porter','pj@gmail.com','Porter','Jenkins'),
  ('bruce','bw@gmail.com','Bruce','Webster'),
  ('kenneth','kr@gmail.com','Kenneth','Rodham'),
  ('jen','jb@gmail.com','Jennifer','Bonnet');

--Followers table
CREATE TABLE Followers(
  userId INTEGER NOT NULL,
  followerId INTEGER NOT NULL,
  PRIMARY KEY (userId,followerId),
  CONSTRAINT FKuserId FOREIGN KEY (userId) REFERENCES User(userId) ON UPDATE cascade ON DELETE cascade
  CONSTRAINT FKfollowerId FOREIGN KEY (followerId) REFERENCES User(userId) ON UPDATE cascade ON DELETE cascade
);

Insert or Ignore into Followers (userId, followerId) Values
  (1,2),(2,1),(3,1),(5,1),(6,14),(7,14),(10,11),(15,2),
  (1,3),(2,3),(3,2),(5,3),(7,1),(7,15),(10,13),(15,3),
  (1,4),(2,4),(3,4),(5,4),(7,2),(8,1),(11,4),(15,4),
  (1,5),(2,5),(3,5),(5,7),(7,3),(8,2),(11,6),(15,5),
  (1,6),(2,6),(3,6),(5,9),(7,4),(8,3),(11,8),(15,6),
  (1,7),(2,7),(3,7),(5,11),(7,5),(8,4),(12,4),(15,7),
  (1,8),(2,8),(3,8),(5,13),(7,6),(8,5),(12,1),(15,8),
  (1,9),(2,9),(3,9),(5,15),(7,8),(9,1),(12,2),(15,9),
  (1,10),(2,10),(3,10),(6,2),(7,9),(9,2),(12,5),(15,10),
  (1,11),(2,11),(4,1),(6,4),(7,10),(9,3),(12,4),(15,11),
  (1,12),(2,12),(4,2),(6,8),(7,11),(9,4),(13,2),(15,12),
  (2,13),(2,14),(4,3),(6,10),(7,13),(10,3),(14,4),(15,13),
  (2,15),(4,5),(4,6),(4,7),(6,12),(7,12),(10,7),(15,1),(15,14);

--Tweet table
CREATE TABLE Tweet(
  tweetId INTEGER PRIMARY KEY,
  userId INTEGER NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_promoted INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT FKuserId FOREIGN KEY (userId) REFERENCES User(userId) ON UPDATE cascade ON DELETE cascade
);

--inserting promoted tweets first
insert into Tweet (userId, created_at,is_promoted) values
  (1,'2018-01-19 19:15:13',1), (12,'2008-05-08 09:40:45',1),
  (11,'2019-07-04 06:49:34',1),(11,'2004-03-14 11:54:00',1),
  (11,'2003-07-06 02:16:24',1);

--then inserting regular tweets
insert into Tweet (userId, created_at) values
  (2,'2011-08-08 13:48:50'),(2,'2014-09-30 01:56:31'),
  (13,'2011-03-15 11:48:20'),(3,'2021-10-15 08:58:01'),
  (2,'2011-08-08 13:47:38'),(3,'2013-04-08 08:29:49'),
  (12,'2011-08-08 03:20:57'),(4,'2011-09-17 07:17:42'),
  (7,'2008-06-24 03:20:57'),(4,'2017-09-12 07:41:47'),
  (9,'2020-10-17 12:12:29'),(5,'2004-07-26 06:41:17'),
  (6,'2005-08-11 21:50:55'),(5,'2006-03-17 03:48:08'),
  (8,'2014-08-16 03:04:37'),(8,'2009-09-19 23:01:09'),
  (1,'2018-01-01 02:05:49'),(8,'2018-06-17 01:12:22'),
  (1,'2012-01-04 12:24:37'),(11,'2015-05-21 02:38:52'),
  (1,'2007-07-02 05:16:22'),(11,'2014-05-01 04:26:32'),
  (1,'2012-01-04 12:24:37'),(13,'2016-08-06 06:43:07'), 
  (2,'2019-10-24 13:36:07'),(12,'2019-10-23 09:13:30'),
  (3,'2007-10-07 01:19:56'),(14,'2011-01-14 00:40:03'),
  (5,'2008-04-23 04:07:45'),(12,'2002-07-18 06:36:41'),
  (1,'2013-01-06 16:34:55'), (12,'2018-03-28 10:34:48'),
  (15,'2020-10-01 14:27:58'),(11,'2021-09-19 19:38:49'),
  (14,'2013-11-23 03:42:46');
  



--Tweet_content table
CREATE TABLE Tweet_content(
  tweetId INTEGER AUTO_INCREMENT PRIMARY KEY,
  tweetBody TEXT,
  picture BLOB DEFAULT NULL,
  video BLOB DEFAULT NULL,
  CONSTRAINT FKtweetId FOREIGN KEY (tweetId) REFERENCES Tweet(tweetId) ON UPDATE cascade ON DELETE cascade
);

insert into Tweet_content (tweetBody) values 
  ('hi'),('hi #GoCougars hi'),('hi'),('hi'),('hi'),('hi'),('hi'),
  ('hi'),('hi'),('hi'),('hi'),('hi'),('hi'),('hi'),('hi'),
  ('hi'),('#GoCougars'),('hi'),('hi'),('hi'),('hi'),('hi'),('hi'),
  ('hi'),('hi'),('hi'),('hi'),('hi'),('hi'),('hi'),('hi'),
  ('hi #GoCougars hi'),('hi'),('hi #GoCougars hi'),('#GoCougars'),
  ('hi'),('hi'),('hi'),('hi'),('#GoCougars');


--Views table
CREATE TABLE Views(
  tweetId INTEGER,
  userId INTEGER,
  PRIMARY KEY (tweetId,userId),
  CONSTRAINT FKtweetId FOREIGN KEY (tweetId) REFERENCES Tweet(tweetId) ON UPDATE cascade ON DELETE cascade,
  CONSTRAINT FKuserId FOREIGN KEY (userId) REFERENCES User(userId) ON UPDATE cascade ON DELETE cascade
);

Insert or Ignore into Views (tweetId, userId) Values
  (1,2),(2,1),(3,1),(5,1),(6,14),(7,14),(10,11),(15,2),
  (1,3),(2,3),(3,2),(5,3),(7,1),(7,15),(10,13),(15,3),
  (1,4),(2,4),(3,4),(5,4),(7,2),(8,1),(11,4),(15,4),
  (1,5),(2,5),(3,5),(5,7),(7,3),(8,2),(11,6),(15,5),
  (1,6),(2,6),(3,6),(5,9),(7,4),(8,3),(11,8),(15,6),
  (1,7),(2,7),(3,7),(5,11),(7,5),(8,4),(12,4),(15,7),
  (1,8),(2,8),(3,8),(5,13),(7,6),(8,5),(12,1),(15,8),
  (1,9),(2,9),(3,9),(5,15),(7,8),(9,1),(12,2),(15,9),
  (1,10),(2,10),(3,10),(6,2),(7,9),(9,2),(12,5),(15,10),
  (1,11),(2,11),(4,1),(6,4),(7,10),(9,3),(12,4),(15,11),
  (1,12),(2,12),(4,2),(6,8),(7,11),(9,4),(13,2),(15,12),
  (2,13),(2,14),(4,3),(6,10),(7,13),(10,3),(14,4),(15,13),
  (2,15),(4,5),(4,6),(4,7),(6,12),(7,12),(10,7),(15,1),(15,14),
  (13,15),(13,5),(13,6),(13,7),(13,12),(13,12),(13,7),(13,1),(13,14);


--Retweets table
CREATE TABLE Retweets(
  tweetId INTEGER,
  userId INTEGER,
  PRIMARY KEY (tweetId,userId),
  CONSTRAINT FKtweetId FOREIGN KEY (tweetId) REFERENCES Tweet(tweetId) ON UPDATE cascade ON DELETE cascade,
  CONSTRAINT FKuserId FOREIGN KEY (userId) REFERENCES User(userId) ON UPDATE cascade ON DELETE cascade
);

Insert or Ignore into Retweets (tweetId, userId) Values
  (1,2),(2,1),(3,1),(5,1),(6,14),(7,14),(10,11),(15,2),
  (1,3),(2,3),(3,2),(5,3),(7,1),(7,15),(10,13),(15,3),
  (1,4),(2,4),(3,4),(5,4),(7,2),(8,1),(11,4),(15,4),
  (1,5),(2,5),(3,5),(5,7),(7,3),(8,2),(11,6),(15,5),
  (1,6),(2,6),(3,6),(5,9),(7,4),(8,3),(11,8),(15,6),
  (1,7),(2,7),(3,7),(5,11),(7,5),(8,4),(12,4),(15,7),
  (1,8),(2,8),(3,8),(5,13),(7,6),(8,5),(12,1),(15,8),
  (1,9),(2,9),(3,9),(5,15),(7,8),(9,1),(12,2),(15,9),
  (1,10),(2,10),(3,10),(6,2),(7,9),(9,2),(12,5),(15,10),
  (1,11),(2,11),(4,1),(6,4),(7,10),(9,3),(12,4),(15,11),
  (1,12),(2,12),(4,2),(6,8),(7,11),(9,4),(13,2),(15,12),
  (2,13),(2,14),(4,3),(6,10),(7,13),(10,3),(14,4),(15,13),
  (2,15),(4,5),(4,6),(4,7),(6,12),(7,12),(10,7),(15,1),(15,14);

--Likes table
CREATE TABLE Likes(
  tweetId INTEGER,
  userId INTEGER,
  PRIMARY KEY (tweetId,userId),
  CONSTRAINT FKtweetId FOREIGN KEY (tweetId) REFERENCES Tweet(tweetId) ON UPDATE cascade ON DELETE cascade,
  CONSTRAINT FKuserId FOREIGN KEY (userId) REFERENCES User(userId) ON UPDATE cascade ON DELETE cascade
);

Insert or Ignore into Likes (tweetId, userId) Values
  (1,2),(2,1),(3,1),(5,1),(6,14),(7,14),(10,11),(15,2),
  (1,3),(2,3),(3,2),(5,3),(7,1),(7,15),(10,13),(15,3),
  (1,4),(2,4),(3,4),(5,4),(7,2),(8,1),(11,4),(15,4),
  (1,5),(2,5),(3,5),(5,7),(7,3),(8,2),(11,6),(15,5),
  (1,6),(2,6),(3,6),(5,9),(7,4),(8,3),(11,8),(15,6),
  (1,7),(2,7),(3,7),(5,11),(7,5),(8,4),(12,4),(15,7),
  (1,8),(2,8),(3,8),(5,13),(7,6),(8,5),(12,1),(15,8),
  (1,9),(2,9),(3,9),(5,15),(7,8),(9,1),(12,2),(15,9),
  (1,10),(2,10),(3,10),(6,2),(7,9),(9,2),(12,5),(15,10),
  (1,11),(2,11),(4,1),(6,4),(7,10),(9,3),(12,4),(15,11),
  (1,12),(2,12),(4,2),(6,8),(7,11),(9,4),(13,2),(15,12),
  (2,13),(2,14),(4,3),(6,10),(7,13),(10,3),(14,4),(15,13),
  (2,15),(4,5),(4,6),(4,7),(6,12),(7,12),(10,7),(15,1),(15,14);


--Replies table
CREATE TABLE Replies(
  parent_tweetId INTEGER,
  tweetId INTEGER,
  PRIMARY KEY (parent_tweetId,tweetId),
  CONSTRAINT FKtweetId FOREIGN KEY (parent_tweetId) REFERENCES Tweet(tweetId) ON UPDATE cascade ON DELETE cascade,
  CONSTRAINT FKtweetId FOREIGN KEY (tweetId) REFERENCES Tweet(tweetId) ON UPDATE cascade ON DELETE cascade
);

Insert or Ignore into Replies (parent_tweetId,tweetId) Values
  (1,2),(2,1),(3,1),(5,1),(6,14),(7,14),(10,11),(15,2),
  (1,3),(2,3),(3,2),(5,3),(7,1),(7,15),(10,13),(15,3),
  (1,5),(2,5),(3,5),(5,7),(7,3),(8,2),(11,6),(15,5),
  (1,6),(2,6),(3,6),(5,9),(7,4),(8,3),(11,8),(15,6),
  (1,7),(2,7),(3,7);


-- Query Construction section:

-- Q1) Count the number of tweets by user. Sort by number of tweets, highest to lowest

select userId, count(tweetId) as numTweets
from Tweet
group by userId
order by numTweets desc;

-- Q2) Get a list of the top 5 most liked tweets

select tweetId from (
  select tweetId, count(userId) as numLikes
  from Likes
  group by tweetId
  order by numLikes desc
  limit 5);


-- Q3) Which promoted tweet has the most views?


select tweetId from (
  select t.tweetId as tweetId, count(v.userId) as numViews 
  from Tweet t 
  inner join Views v
  on t.tweetId = v.tweetId
  where t.is_promoted=1 
  group by v.tweetId
  order by numViews desc
  limit 1);

-- Q4) Get a list of each user's retweets

select userId, GROUP_CONCAT(tweetId,',') retweeted_tweedIds
from Retweets
group by userId;

-- Q5) Get a list of each user's followers

select userId, GROUP_CONCAT(followerId,',') followerIds
from Followers
group by userId;

-- Q6) Count the number tweets containing the hashtag #GoCougars

select count(tweetBody) as GoCougarsTweets from Tweet_content where tweetBody like '%#GoCougars%';


-- Q7) Which day of the week do users tweet the most?

select weekday from (
  select
    case cast (strftime('%w', created_at) as integer)
    when 0 then 'Sunday'
    when 1 then 'Monday'
    when 2 then 'Tuesday'
    when 3 then 'Wednesday'
    when 4 then 'Thursday'
    when 5 then 'Friday'
    else 'Saturday' end as weekday, count(tweetId) as numTweets
  from Tweet
  group by weekday
  order by numTweets desc
  limit 1);

