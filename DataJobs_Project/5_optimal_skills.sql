/*
Question: What are the most optimal skills for a data analyst job? (1. In high demand, 2. High salary)
- Identify the skills that are most frequently mentioned in job postings for data analyst positions and associated with the high average salaries.
- Concentrate on remote posistions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial stability (high salary) offering insights for career development in data analytics.
*/

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.job_work_from_home = TRUE
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC     
LIMIT 25;

    

