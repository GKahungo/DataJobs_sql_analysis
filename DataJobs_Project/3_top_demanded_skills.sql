/*
Question: What are the most in demand skills for Data Analysts?
- Join job_postings to inner join table similar to query 2.
- Identify the top 5 skills for Data Analysts.
- Focus on all job postings.
- Why? To understand the skills that are most sought after in the Data Analyst job market.
*/

SELECT 
    skills_dim.skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 5;


/*
The top 5 skills for Data Analysts based on the job postings are:
1. SQL
2. Excel
3. Python
4. Tableau
5. Power BI
These skills are essential for Data Analysts to perform data manipulation, analysis, and visualization tasks effectively.
*/

