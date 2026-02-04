-- Practice Problem 1:
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS average_yearly_salary,
    AVG(salary_hour_avg) AS average_hourly_salary
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

-- Practice Problem 2:
SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(job_id) AS job_postings
FROM job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY month
ORDER BY month;

-- Practice Problem 3:
SELECT
    companies.name AS company_name
FROM
    job_postings_fact AS jobs
INNER JOIN
    company_dim AS companies
ON
    jobs.company_id = companies.company_id
WHERE
    jobs.job_health_insurance = TRUE AND
    EXTRACT(Quarter FROM jobs.job_posted_date) = 2 AND
    EXTRACT(YEAR FROM jobs.job_posted_date) = 2023;


-- Case expression examples
-- example 1
SELECT 
    job_title_short,
    job_location,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE  'Onsite'
    END AS location_category
FROM job_postings_fact;

-- example 2
SELECT 
    COUNT(job_id) AS total_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE  'Onsite'
    END AS location_category
FROM job_postings_fact
GROUP BY location_category;

-- example 3
SELECT 
    COUNT(job_id) AS total_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE  'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

-- Subquery example
SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = TRUE 
    ORDER BY company_id
)

-- Common Table Expressions (CTEs) example
WITH company_job_counts AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_counts.total_jobs
FROM company_dim
LEFT JOIN company_job_counts 
ON company_dim.company_id = company_job_counts.company_id
ORDER BY total_jobs DESC;

SELECT * FROM company_job_counts

SELECT * FROM january_jobs;

SELECT * FROM february_jobs;

SELECT * FROM march_jobs;

-- Union example
SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION 

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;

-- Union All example
SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;