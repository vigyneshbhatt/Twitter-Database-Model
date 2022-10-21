# Twitter-Database-Model
**A presumed SQL model of Twitter's Database**

**Twitter ERD**

Twitter has Users and Tweets. Each user needs to have a unique userHandle and an email but I am
not using either of those as the Primary Key and instead have an arbitrary Integer userId as the
Primary Key because lookups of integers have better performance than lookups on variable length
strings (Detailed explanation in ERD diagram).

Each tweet needs to have a unique identifier and an associated userId to represent the user who sent
out the tweet. Each user can send out tweets 280 characters long and the tweet can have a text body,
picture, video or a combination of the three. The data that I have inserted into the tables only has
tweets with a text body but there are columns that can hold picture and videos as well.

**● Entities**
This initial analysis tells us that there’s going to be two strong entities. Users and Tweets. Each tweet
would map to a user using the userId Foreign key.

*User*

User is a strong entity with userId as the Primary Key. There is no column dependency except on the
Primary Key and there’s no redundancy in the table. So the table is in BCNF. User has a dependent
weak entity - Followers table that keeps track of a user’s followers (Description in ERD diagram). This
table has a composite Primary Key and has no column dependency. So this table is also in BCNF.

*Tweet*

I have made two separate tables for Tweet - One that holds the tweet metadata and one that holds the
tweet content (reason listed in the ERD diagram). These tables have a 1-1 relationship with tweetIds
as the Primary Key and the tweetId in Tweet_content referring to tweetId in Tweet. Both Tweet and
Tweet_content have singular, unique and required Primary keys so both the tables ought to be strong
entities but the Tweet_content table’s Primary Key is derived from Tweet’s Primary Key. So
Tweet_content is a weak entity. Both the tables have no column dependency so both of them are in
BCNF.

There are 4 other tables for a Tweet that are all weak entities - One each for Likes, Views, Retweets
and Replies. Detailed description for all the 4 are in the ERD diagram. Each of these 4 tables have
composite primary keys and do not have any column dependency. So each of these 4 tables are in
BCNF.

**● Relationships**

*User and Tweets*

Each tweet can be made by one and only one user (Maxima) and if there’s a tweet there needs to be
a user that made the tweet (Minima). Each user can make Many tweets (Maxima) but does not need
to make a tweet (Minima) So the relationship between User and Tweets is M(0)-1(1).

*User and Followers*

User and Followers have a One to Many relationship 1(1)-M(0) because a user need not have an
entry in followers and can have multiple entries in followers. But an entry in followers can correspond
to only one user and needs to correspond to at least one user.

*Tweet and Tweet_content*

Tweet and Tweet_content have a One to One relationship 1(1)-1(1). Each entry in tweet can
correspond to only one entry in Tweet_content and needs to have a corresponding entry in
Tweet_content.

*Tweet and Views, Likes, Replies, Retweets*

The 4 sister tables Views, Likes, Replies, Retweets represent relationships between a user action on
a tweet and the tweet and the tables are very similarly implemented. Separate descriptions for all the
4 are in the ERD diagram. Since the tables are similarly implemented, a description for one
relationship is representative of all the 4 relationships.

Tweet and Views have a One to Many relationship 1(1)-M(0) because a Tweet need not have an entry
in Views and can have multiple entries in Views. But an entry in Views can correspond to only one
Tweet and needs to correspond to at least one Tweet.

**Some Key Takeaways**

In the first draft of the implementation, I had implemented a user’s Followers and the user’s Follows
as text arrays in the User table itself and similarly, I had implemented Likes, Retweets, Replies and
Views as Text Arrays in the Tweet table. Although that would lead to faster lookups in most cases (I
could pass in a userId and get a list of everyone the user follows or user’s followers), I realized that
the database would have frequent updates and inserts as well. So the database needed to be
optimized for both lookups as well as Updates and Inserts. I needed to find a good balance between
optimizing for lookups and optimizing for update operations.

Having centralisation in the table design would not help this cause and would also lead to duplication
of data (Followers and Follows). Keeping the data decentralized (modeling relationships as separate
tables) would allow for easier inserts and updates and would help keep the data dynamic and more
structured while losing out only slightly in terms of performance on lookups.

I also learnt that the Single Responsibility Principle (SRP), which is concept used in Object oriented
programming, can be applied to Database modeling where the tables are analogous to classes,
columns are analogous to properties and individual rows are analogous to class instances or objects.
Applying SRP to Database modeling helps keep the data clean and more structured

