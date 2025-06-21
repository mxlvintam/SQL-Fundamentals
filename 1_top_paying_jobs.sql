/*Question: What are the top paying data analyst jobs?
- Identify the top 10 highest paying data analyst jobs that are available in Singapore
- Focuses on job postings with specific salaries (removing nulls)
- Why do this? Highlight the top paying opportunities for data analysts, offering insights to be pursuing as a data analyst
*/

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