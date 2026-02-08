/*
Question: What are the optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrate on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis.
*/

-- Short version without CTEs for simplicity
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25

-- Long version with CTEs for clarity and maintainability
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10 
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25

/*
Strategic Insights: The High-Demand, High-Pay Sweet Spot
1. The Essential Powerhouse: Python & Tableau
   - Python and Tableau stand out as the most strategic skills to acquire. With over 230+ job postings 
   each and average salaries exceeding $\$99,000$, they provide the highest probability of finding a 
   well-paying role quickly.
   - R follows closely as a high-demand statistical language with a strong average salary of $\$100,499$.
2. Premium Cloud & Data Infrastructure Skills
   - Cloud-based technologies command the highest average salaries. Proficiency in Snowflake ($\$112,948$), 
   Azure ($\$111,225$), and AWS ($\$108,317$) represents a significant salary bump over traditional data 
   tools.
   - Specialized languages like Go ($\$115,320$) offer the highest average pay in this dataset, though the 
   demand is more niche.
3. The Shift to Modern Business Intelligence
   - Next-generation BI and storage tools like Looker ($\$103,795$) and BigQuery ($\$109,654$) pay better 
   than legacy systems, indicating that companies are willing to pay a premium for analysts who can navigate 
   modern data stacks.
4. Database Management & Engineering Integration
   - Expertise in Oracle ($\$104,534$) and NoSQL ($\$101,414$) remains lucrative, while project management 
   and collaboration tools like Jira and Confluence (both over $\$104k$) suggest that analysts embedded in 
   high-functioning engineering teams earn more.


Summary Table: Top Optimal Skills
Skill       Demand (Postings)   Avg. Salary ($) Strategic Value
Python      236                 "$101,397"      Highest Versatility
Tableau     230                 "$99,288"       Visualization Standard
R           148                 "$100,499"      Statistical Excellence
Snowflake   37                  "$112,948"      Cloud Data Premium
Looker      49                  "$103,795"      Modern BI Specialist
*/