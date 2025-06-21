# Introduction
This project explores top paying jobs and in demand skills to identify high salaries for data analytics in Singapore. 

[Check it out here](https://github.com/mxlvintam/SQL-Fundamentals)

# Background
Being a fresh graduate in Singapore without a background in data analytics, this project was created to kick start my experience in data analysis.

[Click here](https://www.lukebarousse.com/sql) for data.

### Some questions I wanted to answer were:

1. What are the top paying data analyst jobs?
2. What are the skills required for these jobs?
3. Which skills are associated with higher salaries?

### Tools I Used
- **SQL**: The backbone for my analysis, allowing me to query the database and uncover insights
- **PostgreSQL**: Database management system. 
- **Visual Studio Code**: My go-to code editor for database management and executing queries.
- **Git & Github**: Version control and sharing, ensuring collaboration and tracking. 

# The Analysis

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on Singapore. 
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Singapore' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
Here is a breakdown of the top data analyst jobs in 2023 for Singapore: 

**Salary Range**: Top 10 paying data analyst roles span from $105,000 to $149,653.

**Employers**: Companies like Bosch Group, 2K, and ADDX are among those offering high salaries.

### 2. Skills for Top Paying Jobs
Job postings were joined with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_location = 'Singapore' AND
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
ORDER BY 
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023 for Singapore:

- **Python** is leading with a count of **6**.
- **SQL**, **tableau**, and **Spark** are also sought after with a count of **4**. 
- Other skills like **Excel** and **Power BI** show lower degree of demand. 

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Singapore'
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;
```
Here's the overview of the most demanded skills for data analysts in 2023 for Singapore:

- **SQL** and **Python** are foundational skills for data processing. 
- While **Excel** and **Tableau** are essential in decision support and storytelling.

| Skills    | Demand Count|
|-----------|-------------|
|SQL|3,635|
|Python|3,080|
|Excel|2,294|
|Tableau|2,199|
|R|1,315|

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    COUNT(job_postings_fact.job_id),
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_location = 'Singapore'
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 30;
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- Highest paying skill: **Spark**
- Other high value specialised skills include: **Looker, Linux, and Flow**.
- Jobs requiring **Python** are generally higher paying than jobs requiring **SQL**.

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT  
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,    
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_location = 'Singapore'
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 5
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Here's a breakdown of the most optimal skills for Data Analysts in 2023 for Singapore:

- High Demand Skills of **Python** stands out with a total count of 12 with an average salary of $103,713, indicating proficiency in the languages is highly valued.
- Demand for tools like **Excel, Tableau, and R** have lower demand counts, ranging from 6 to 8, and average salaries of $94,676 to $100,569, suggesting the importance of data visualisation. 
- Despite being the most in-demand skill of 15 mentions, **SQL** offers the lowest average salary ($87,644). This suggests that there may be too many candidates with basic SQL skills and SQL alone is insufficient for premium roles, hence, could be entry-level bias. 

| Skills    | Demand Count|Average Salary|
|-----------|-------------|--------------|
|Python|12|103,713|
|Excel|8|100,569|
|Tableau|8|95,088|
|R|6|94,676|
|SQL|15|87,644|
# Conclusions

### Insights
SQL is the most demanded skill in the data analytics job market. However, being the "basics" of data analytics, individuals are expected to be proficient in the programming language and offers a lower salary compared to proficiency in other tools. 

### Closing Thoughts
Throughout this project, I've manage to pickup the basics of SQL and provided valuable insights in the data analytics job market. The findings could serve as a guide for skill prioritisation, job search and the importance of continous learning for individuals in Singapore. 