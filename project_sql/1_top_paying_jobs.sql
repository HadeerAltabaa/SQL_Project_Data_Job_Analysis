/* 
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment trends and salary expectations in the field.
*/

SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/* 
Based on the top 10 highest-paying Data Analyst roles in 2023:
- Salary Range: Salaries range from $\$184,000$ to $\$650,000$, with an average of $\$264,506$.
- Top Earner: Mantys is a major outlier, offering $\$650,000$ for a "Data Analyst" role.
- Seniority Matters: Most high-paying roles are senior-level positions, including Directors, 
    Associate Directors, and Principal Data Analysts.
- Remote Work: All top 10 positions are full-time and remote ("Anywhere"), reflecting a high demand 
    for top talent regardless of location.
- Key Industries: High compensation is found in specialized sectors like FinTech (SmartAsset), 
    Social Media (Meta, Pinterest), and Telecommunications (AT&T).
*/