/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query.
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
  helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

/*
Concise Insights:
- The "Big Three": SQL (8/10), Python (7/10), and Tableau (6/10) are the most critical 
    skills for securing the highest-paying roles.
- Programming Depth: Beyond Python, R (4/10) remains relevant, while Pandas and Go also 
    appear in elite job requirements.
- Data Tools & Infrastructure: Proficiency in Snowflake, Databricks, and Azure indicates 
    that high-paying roles often involve managing large-scale cloud data environments.
- Software Engineering Practices: The inclusion of Git, Bitbucket, and Atlassian (Jira/Confluence) 
    suggest that top-tier Data Analysts are expected to follow formal development workflows.
- Traditional Tools: Excel (3/10) still maintains a presence even at the highest compensation levels.
*/