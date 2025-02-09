-- Netflix Data Analysis SQL Project
-- Description: This project explores Netflix data using various SQL queries.
-- It includes data retrieval, filtering, aggregation, window functions, string functions, logical conditions, date operations, and joins.
-- Ideal for data analysis and SQL practice.

use netflix;
select * from netflix_titles;

-- Find all movies released after 2017
SELECT * FROM netflix_titles 
WHERE type = 'Movie' AND release_year > 2017;

-- Find all TV shows available in India
SELECT * FROM netflix_titles 
WHERE type = 'TV Show' AND country = 'India';

-- Count number of movies and TV shows
SELECT type, COUNT(*) AS count FROM netflix_titles 
GROUP BY type;

-- Find the most recent additions to Netflix
SELECT * FROM netflix_titles 
ORDER BY date_added DESC 
LIMIT 8;

-- Using Window Function: Rank movies by release year
SELECT title, release_year, RANK() OVER (ORDER BY release_year DESC) AS ranking FROM netflix_titles
WHERE type = 'Movie';

-- Using Join: Find TV shows with the same director
SELECT N1.title AS Show1, N2.title AS Show2, N1.director FROM netflix_titles N1
JOIN netflix_titles N2 ON N1.director = N2.director AND N1.show_id <> N2.show_id
WHERE N1.type = 'TV Show' AND N2.type = 'TV Show';

-- Aggregate Function: Find average duration of movies
SELECT AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS avg_duration FROM netflix_titles 
WHERE type = 'Movie' AND duration LIKE '%min';

-- String Function: Extract first word from title
SELECT title, SUBSTRING_INDEX(title, ' ', 1) AS first_word FROM netflix_titles;

-- Date and Time Function: Find records added in the last 6 months
SELECT * FROM netflix_titles 
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


-- Find titles containing 'love'
SELECT * FROM netflix_titles WHERE title LIKE '%love%';

-- Find TV Shows from United States or Japan released after 2010
SELECT * FROM netflix_titles 
WHERE type = 'TV Show' AND (country = 'United States' or country = 'Japan') AND release_year > 2010;

-- Assign a unique row number to each movie ordered by release year
SELECT title, release_year, ROW_NUMBER() OVER (ORDER BY release_year DESC) AS row_num 
FROM netflix_titles WHERE type = 'Movie';

-- Divide movies into 4 equal parts based on release year
SELECT title, release_year, NTILE(6) OVER (ORDER BY release_year DESC) AS quartile 
FROM netflix_titles WHERE type = 'Movie';

-- Compare each movie's release year with the previous movie
SELECT title, release_year, LAG(release_year, 1) OVER (ORDER BY release_year) AS prev_year 
FROM netflix_titles WHERE type = 'Movie';

-- Compare each movie's release year with the next movie
SELECT title, release_year, LEAD(release_year, 1) OVER (ORDER BY release_year) AS next_year 
FROM netflix_titles WHERE type = 'Movie';




