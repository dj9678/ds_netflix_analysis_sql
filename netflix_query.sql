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
GROUP BY rating ORDER BY "rating_order" DESC 
LIMIT 10;
-- check what genre is most popular in Netflix
SELECT listed_in, COUNT(listed_in) AS "listed_in_order"
FROM netflix_titles
GROUP BY listed_in ORDER BY "listed_in_order" DESC
LIMIT 10;

-- check what is the top 5 countries that release the most content on 2021
SELECT country, COUNT(release_year) AS release_2021
FROM netflix_titles
WHERE release_year = 2021
GROUP BY country ORDER BY release_2021 DESC
LIMIT 5;

-- number of contents added in United States and South Korea using Union
	SELECT country, date_added, COUNT(date_added) AS added_date
	FROM netflix_titles
	WHERE country = 'United States' 
	GROUP BY 1, 2 
UNION
	SELECT country, date_added, COUNT(date_added) AS added_date
	FROM netflix_titles	
	WHERE country = 'South Korea' 
	GROUP BY 1, 2 
ORDER BY country, date_added

-- check how many null is in the country column
SELECT COUNT(*)
FROM netflix_titles
WHERE country is NULL;

-- countries having most contents released on year of 2019, 2020, 2021
-- (be careful for the country rank since it is not sorted for the columns of release_2020 and release_2020)
SELECT 
	country, 
	COUNT(CASE WHEN release_year = 2021 THEN 1 ELSE null END) AS release_2021,
	COUNT(CASE WHEN release_year = 2020 THEN 1 ELSE null END) AS release_2020,
	COUNT(CASE WHEN release_year = 2019 THEN 1 ELSE null END) AS release_2019
FROM netflix_titles
GROUP BY country ORDER BY release_2021 DESC
LIMIT 10;

-- movie and tv show added on each months
SELECT 
	DATE_TRUNC('month',date_added) AS added_month,
	identifier, COUNT(*) as added_count
FROM netflix_titles 
GROUP BY 1,2 ORDER BY 1;

-- most popular genre added by country during April, 2021
SELECT 
	date_added,
	country,
	listed_in, 
	COUNT(listed_in) AS genre_count
FROM netflix_titles
WHERE date_added BETWEEN '2021-04-01' AND '2021-04-30'
GROUP BY 1,2,3 ORDER BY 4 DESC;

-- check which country add same genre more than 5
SELECT 
	date_added,
	country,
	listed_in, 
	COUNT(listed_in) AS genre_count
FROM netflix_titles
GROUP BY 1,2,3 
HAVING COUNT(*) > 5
ORDER BY 4 DESC

-- check how many tv show or movie added in South Korea with date_added using with function
WITH events AS (
	SELECT 
		date_added,
		country,
		identifier, 
		COUNT(identifier) AS identifier_count
	FROM netflix_titles
	GROUP BY 1,2,3);

SELECT 
	country, 
	DATE_TRUNC('month', date_added) AS added_month,
	identifier, SUM(identifier_count)
FROM events
WHERE country = 'South Korea' 
GROUP BY 1,2,3  ORDER BY 2 DESC;

-- count identifier over date_added using window function
SELECT 
	date_added,
	country,
	identifier, COUNT(identifier) OVER (ORDER BY date_added) AS identifier_count
FROM netflix_titles;

-- count number of added 'TV Show' in United States with yearly difference(lead_difference) and sum of count(identifier_sum)  
SELECT date_added,
       country,
	   identifier,
	   LEAD(identifier_count) OVER (ORDER BY date_added) AS lead,
	   identifier_count,
	   LEAD(identifier_count) OVER (ORDER BY date_added) - identifier_count AS lead_difference,
       identifier_sum
FROM (
	SELECT 
		date_added,
		country,
		identifier,
		COUNT(identifier) AS identifier_count,
		SUM(COUNT(identifier)) OVER (PARTITION BY identifier ORDER BY date_added) AS identifier_sum
	FROM netflix_titles 
	WHERE country = 'United States'
	GROUP BY 1,2,3
	HAVING identifier='TV Show'
) sub
