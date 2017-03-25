create database IOT CHARACTER SET utf8;

CREATE TABLE `tbl_twitter_posts_all` (
  `Post_ID` bigint(20) DEFAULT NULL,
  `Post_Date` varchar(50) DEFAULT NULL,
  `User` varchar(100) DEFAULT NULL,
  `Text` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

truncate table tbl_twitter_posts_all;

LOAD DATA INFILE '/Users/amendrashrestha/Downloads/Data/Twitter/IOT/Tweets_IOT.tsv'
into table tbl_twitter_posts_all
COLUMNS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 0 LINES;

select * from tbl_twitter_posts limit 10;
select count(*) from tbl_twitter_posts; -- 191744
select count(*) from tbl_twitter_posts_all; -- 258174

select count(*) from tbl_twitter_posts_all where Text like '%iot%'; -- 264333
select count(*) from tbl_twitter_posts_all where Text like '%#iot%'; -- 191801
select count(*) from tbl_twitter_posts_all where Text like '%internetofthings%'; -- 20906
select count(*) from tbl_twitter_posts_all where Text like '%#internetofthings%'; -- 14177

select (264333+191801+20906+14177); --

select count(*) from tbl_twitter_posts T1
INNER JOIN tbl_twitter_posts_all T2
ON T1.Post_ID = T2.Post_ID; -- 56719

-- alter table tbl_twitter_posts_all add index idx_id(Post_ID);

drop table tbl_twitter_posts;

create table tbl_twitter_posts
select Post_ID, DATE_FORMAT(STR_TO_DATE(Post_Date, '%l:%i %p - %e %b %Y'), '%Y-%m-%d') as Post_Date, 
DATE_FORMAT(STR_TO_DATE(Post_Date, '%l:%i %p - %e %b %Y'), '%l:%i %p') as Post_Time, User,
Text from tbl_twitter_posts_all;

select Post_Date, count(*) from tbl_twitter_posts
group by Post_Date
order by 1;

select User, count(*) from tbl_twitter_posts
group by User
order by 2 desc;

select * from tbl_twitter_posts
group by Post_ID
having count(*) > 1 
; -- 837067431768117248

## Removing Duplicates from the table 
select Post_ID from tbl_twitter_posts
group by Post_ID
having count(Post_ID) > 1;

set session old_alter_table = 1;

ALTER IGNORE TABLE tbl_twitter_posts
ADD UNIQUE INDEX idx_forum (Post_ID);

select * from tbl_twitter_posts where Post_ID = '837067431768117248';

select * from tbl_twitter_posts where Post_Date = '2017-03-21'; 