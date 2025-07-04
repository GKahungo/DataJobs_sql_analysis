
## Introduction
A dive into the Data Jobs market focusing on remote data analyst roles. This project explores top paying jobs, in-demand skills and optimal skills to have in data analytics.

SQL queries? Check them out here: [DataJobs_Project](/DataJobs_Project/)

## Background
Driven by a quest to navigate the data analyst job market more effectively, this project was borm from a desire to pinpoint top paid and in demand skills streamlining the effort to find optimal jobs.

The source of the data is from Luke Barousse [SQL Course] (https://lukebarousse.com/sql). It is packed with insights on job titles, salaries, locations and essential skills.

### Questions asked
1. What are the top paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to have for data analyst roles?

## Tools I Used
For my deep dive into the data analyst job market, I used the following tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system ideal for handling the job postings data.
- **Visual Studio Code**: My go to for database management and executing SQL queries.
- **Git and Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
- **Excel:** The chosen tool for data visualisations from my sql queries.

## The Analysis
Each query for this project is aimed at investigating specific aspects of the data analyst job market.
Here is how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, i filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunites in the field.

```sql
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date 
FROM job_postings_fact
JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here is the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying jobs span from $184,000 to $650,000 indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta and AT&T are among those offering high salaries showing a broad interest across different industries.
- **Job Title Variety:** There is a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specialisations within data analystics.

![Top Paying Roles](Assets\top_paying_roles.png)
*Bar graph visualising the salary for the top 10 paying roles for data analysts in 2023. This was generated using excel from my sql query results*

### 2. Skills for Top Paying Jobs
To understand what skills are requires for the top paying jobs, I joined the job postings with the skills data providing insights into what employers value for high compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM job_postings_fact
    JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY top_paying_jobs.salary_year_avg DESC;
```
Here is the breakdown of the most demanded skills for the to 10 highest paying data analyst jobs in 2023:
- **SQL** is the most universal skill.
- **Python, R, Excel**, and **Tableau** are highly demanded.
- **Cloud tools (AWS, Azure, Databricks)** are critical in senior roles.
- **Version control & dev-collab tools (Git, GitLab, Jira)** show increasing relevance for analysts embedded in product/tech teams.

![Skills for Top Paying roles](Assets\skill_count_for_top_roles.png)
*Bar graph visualising the count of skills for the top paying jobs for data analysts. This was generated using excel from my sql query results*

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
```
Here is the breakdown of the most demanded skills for data analysts in 2023.
- **SQL** and **Excel** remain fundamental, emphasising the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualisation Tools** like **Python, Tableau** and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| skills   | demand_count |
|----------|--------------|
| sql      | 7291         |
| excel    | 4611         |
| python   | 4330         |
| tableau  | 3745         |
| power bi | 2609         |

*Table of the demand for the top 5 skills in Data 
Analyst job postings*

### 4. Skills Based on Salary
Exploring the most lucrative skills that can enhance a Data Analyst's earning potential.

```sql
SELECT 
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY average_salary DESC
LIMIT 25;
```
Here is a breakdown of the reuslts for top paying skills for Data Analysts:
- **Hybrid skillsets pay more:** The highest earners tend to combine data analysis with engineering, cloud, and machine learning skills.
- **Beyond SQL and Excel:** While foundational, traditional skills like SQL are not the highest earners anymore — tools like PySpark, Databricks, GitLab, and Airflow push salaries higher.
- **Cloud and MLOps Are the Future:** Skills involving scalability, deployment, and automation are commanding increasing compensation.

| skills        | average_salary |
|---------------|----------------|
| pyspark       | 208172         |
| bitbucket     | 189155         |
| watson        | 160515         |
| couchbase     | 160515         |
| datarobot     | 155486         |
| gitlab        | 154500         |
| swift         | 153750         |
| jupyter       | 152777         |
| pandas        | 151821         |
| elasticsearch | 145000         |
*Table of the average salary for the top 10 paying skills for Data Analysts.*

### 5. The most Optimal skills for Data Analysts
Combining demand and salary data, this query is aimed to target skills that offer job security (high demand) and financial stability (high salary) offering insights for career development in data analytics.

```sql
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
```
Here is a breakdown on the most optimal skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |
*Table of the most optimal skills for Data Analysts sorted by salary*

## What I learned

- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **Analytical Skills:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

## Conclusions
### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.