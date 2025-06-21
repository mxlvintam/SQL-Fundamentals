/*Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst positions
- Focuses on roles with specific salaries in Singapore
- Why? It reveals how different skills impact salary for data analyst and helps identify the most financially rewarding skills to acquire
*/

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