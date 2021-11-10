# ds_netflix_analysis_sql

This repo is aiming to explore the [Netflix Movies and TV Shows](https://www.kaggle.com/shivamb/netflix-shows) data set using PostgreSQL. In order to import data set, which is csv file, you need to create the empty table first with proper data type on each column in PostgreSQL, then import the data.     
</br></br>

## Overview

- Check unique value in the column using `DISTINCT`
- Count number of rows where identifier is 'Move' and identifier is 'TV Show' using `WHERE`
- Look up and count the number of rows where the column of listed_in contains word "Family" using `LIKE`
- Check what is the top 5 countries that release the most content on 2021 using `GROUP BY` and `WHERE`
- Check how many null is in the country column
- Look up the movie and tv show added on each months using `DATE_TRUNC`
- Check the most popular genre added by country during April, 2021 using `COUNT`, `WHERE`, `GROUP BY`, and `ORDER BY`
- Check which country add same genre more than 5 using `HAVING`
- Search how many tv show or movie added by date_added using `WITH` function
- Count number of added 'TV Show' in United States with yearly difference and sum of count using windown function such as `OVER (PARTITION BY ORDER BY)` and `LEAD`

## How to Run

Simply click `netflix_query.sql` on main page of this repo
