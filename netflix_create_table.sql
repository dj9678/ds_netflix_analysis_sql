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
)
