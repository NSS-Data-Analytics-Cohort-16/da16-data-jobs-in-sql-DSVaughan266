-- The dataset for this exercise has been derived from the `Indeed Data Scientist/Analyst/Engineer` [dataset](https://www.kaggle.com/elroyggj/indeed-dataset-data-scientistanalystengineer) on kaggle.com. 

-- Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column.

-- #### Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

-- 1.	How many rows are in the data_analyst_jobs table?

SELECT 
COUNT (*)
FROM data_analyst_jobs;
--ANSWER: 1793

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;
--ANSWER: ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT
	COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';
--ANSWER:	21

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';
--ANSWER:	27

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT 
	location,
	star_rating
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;
--ANSWER:	3

-- 5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count >= 500 AND review_count <= 1000;
--ANSWER:	151

-- 6.	Show the average star rating for companies in each state. 
--		The output should show the state as `state` and the average rating for the state as `avg_rating`. 
--		Which state shows the highest average rating?

SELECT 
	DISTINCT location AS state,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location 
ORDER BY avg_rating DESC;
--ANSWER:	Nebraska

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT 
	DISTINCT title
FROM data_analyst_jobs;

SELECT 
	COUNT(DISTINCT title)
FROM data_analyst_jobs;
--ANSWER:	881

-- 8.	How many unique job titles are there for California companies?

SELECT 
	COUNT(DISTINCT title)
	location
FROM data_analyst_jobs
WHERE location = 'CA';
--ANSWER:	230

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews 
--		across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT 
	company,
	ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
AND company IS NOT NULL
GROUP BY company;
--ANSWER:	40

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. 
--		Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
--		What is that rating?

SELECT 
	company,
	ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
AND company IS NOT NULL
GROUP BY company
ORDER BY AVG(star_rating) DESC;
--ANSWER: 6 Companies have a 4.20 rating
--	      Unilever, General Motors, Nike, American Express, Microsoft, Kaiser Permanente
		
-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT
	DISTINCT title
FROM data_analyst_jobs
WHERE title iLIKE '%Analyst%';
--ANSWER: 774

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
--		What word do these positions have in common?

SELECT
	DISTINCT (title)
FROM data_analyst_jobs
WHERE title NOT iLIKE '%Analyst%'
AND title NOT iLIKE '%Analytics%';
--ANSWER: 4, Tableau

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. 
-- Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top.

SELECT
	domain,
	COUNT(domain) as job_count
FROM data_analyst_jobs
WHERE 
	domain IS NOT NULL
	AND skill = 'SQL'
	AND days_since_posting > 21
GROUP BY domain
ORDER BY job_count DESC
--ANSWER:	Consulting and Business Services	5
--			Consumer Goods and Services			2
--			Computers and Electronics			1
--			Internet and Software				1
--			Real Estate							1
--			Transport and Freight				1


-- Which three industries are in the top 3 on this list? 
-- How many jobs have been listed for more than 3 weeks for each of the top 3?

SELECT
	domain,
	COUNT(domain) as job_count
FROM data_analyst_jobs
WHERE 
	domain IS NOT NULL
	AND skill = 'SQL'
	AND days_since_posting > 21
GROUP BY domain
ORDER BY job_count DESC
LIMIT 3;
--ANSWER:	Consulting and Business Services	5
--			Consumer Goods and Services			2
--			Computers and Electronics			1

