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

-- check how many unique value is in the column of listed_in
SELECT DISTINCT COUNT(listed_in) FROM netflix_titles;

-- count number of rows where the column of listed_in contains word "Family"
SELECT COUNT(*) 
FROM netflix_titles
WHERE listed_in LIKE '%Family%';


