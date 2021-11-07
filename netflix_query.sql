-- create table to import csv file into database
CREATE TABLE netflix_titles (
  	id SERIAL,
 	show_id VARCHAR,
 	Identifier VARCHAR,
  	title VARCHAR,
  	director VARCHAR,
  	casting VARCHAR,
  	country VARCHAR,
  	date_added DATE,
	release_year INT,
  	rating VARCHAR,
  	duration VARCHAR,
  	listed_in VARCHAR,
  	description VARCHAR,
	PRIMARY KEY (id)
);

-- check data is sucessufully imported into table
SELECT * FROM netflix_titles;

-- select data that is classified as 'Movie' in identifier
SELECT * FROM netflix_titles WHERE identifier='Movie'

-- count number of rows where identifier is 'Move' and identifier is 'TV Show'  
SELECT 
	COUNT(CASE WHEN identifier = 'Movie' THEN 1 ELSE null END) AS "Total Number of Movie",
	COUNT(CASE WHEN identifier = 'TV Show' THEN 1 ELSE null END) AS "Total Number of TV Show"
from netflix_titles;

-- to see unique value in the column
SELECT DISTINCT country FROM netflix_titles;
-- check how many unique value is in the column of listed_in
SELECT DISTINCT COUNT(country) FROM netflix_titles;
-- check how many unique value is in the clumn of rating
SELECT DISTINCT COUNT(rating) FROM netflix_titles;

-- count number of rows where the column of listed_in contains word "Family"
SELECT COUNT(*) 
FROM netflix_titles
WHERE listed_in LIKE '%Family%';

-- check top 5 director who have the most of his/her movie or tv shows in Netflix
SELECT director, COUNT(director) AS "value_occurrence"
FROM netflix_titles
GROUP BY director ORDER BY "value_occurrence" DESC
LIMIT 5;
-- check what rating is most popular in Netflix
SELECT rating, COUNT(rating) AS "rating_order"
FROM netflix_titles
GROUP BY rating ORDER BY "rating_order" DESC;
-- check what genre is most popular in Netflix
SELECT listed_in, COUNT(listed_in) AS "listed_in_order"
FROM netflix_titles
GROUP BY listed_in ORDER BY "listed_in_order" DESC;

-- check what is the top 5 countries that release the most content on 2021
SELECT country, COUNT(release_year) AS release_2021
FROM netflix_titles
WHERE release_year = 2021
GROUP BY country ORDER BY release_2021 DESC
LIMIT 5;

-- top 10 countries on different release_year (Care for the country rank since it is not sorted for release_2020 and release_2020)
SELECT 
	country, 
	COUNT(CASE WHEN release_year = 2021 THEN 1 ELSE null END) AS release_2021,
	COUNT(CASE WHEN release_year = 2020 THEN 1 ELSE null END) AS release_2020,
	COUNT(CASE WHEN release_year = 2019 THEN 1 ELSE null END) AS release_2019
FROM netflix_titles
GROUP BY country ORDER BY release_2021 DESC
LIMIT 10;


