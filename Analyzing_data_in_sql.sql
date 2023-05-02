-- BUSINESS QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
   
   select gender, count(*) total
   from hr
   where age >=18 and termdate is null
   group by gender
   order by total desc;
     
-- 2. What is the race/ethnicity breakdown of employees in the company?

   select race, count(*) total
   from hr
   where age >=18 and termdate is null
   group by race
   order by total desc;

-- 3. What is the age distribution of employees in the company?
   select min(age)youngest, max(age)oldest
   from hr
   where age >=18 and termdate is null;
   
   select
  CASE
    when age between 18 and 24 then '18-24'
    when age between 25 and 34 then '25-34'
    when age between 35 and 44 then '35-44'
    when age between 45 and 54 then '45-54'
    when age between 55 and 64 then '55-64'
    else '65+'
  end AS age_group,gender,
  COUNT(*) AS count
from hr
where age >=18 and termdate is null
GROUP BY age_group,gender
order by age_group;



-- 4. How many employees work at headquarters versus remote locations?

select location, COUNT(*) AS total
from hr
where age >=18 and termdate is null
group by location;

-- 5. What is the average length of employment for employees who have been terminated?

select round(avg(DATEDIFF(termdate, hire_date))/365.25,2) AS avg_length_employment
from hr
where termdate <= curdate() and termdate is not null  and age >=18;

-- 6. How does the gender distribution vary across departments and job titles?

select department, gender, COUNT(*) AS total
from hr
where age >=18 and termdate is null
group by department, gender
order by department;


select jobtitle, gender, COUNT(*) AS total
from hr
where age >=18 and termdate is null
group by jobtitle, gender
order by jobtitle;

-- 7. What is the distribution of job titles across the company?

select jobtitle,COUNT(*) AS total
from hr
where age >=18 and termdate is null
group by jobtitle
order by total desc;

-- 8. Which department has the highest turnover rate?

SELECT department, 
      total,
      terminated_total,
      terminated_total/total as turnover_rate
      from (
      select department,
      count(*) as total,
      sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminated_total
      from hr
      where age >= 18
      group by department)as t1
      order by turnover_rate  desc;

      

-- 9. What is the distribution of employees across locations by city and state?

select  location_state, COUNT(*) as total 
from hr 
where age >=18 and termdate is null
group by location_state 
order by total  DESC;

select  location_city, COUNT(*) as total 
from hr 
where age >=18 and termdate is null
group by location_city 
order by total  DESC;



-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT hire_year,total_hire, terminations, 
total_hire - terminations as net_employee_change ,
round((total_hire - terminations)/total_hire * 100,2) as employee_change_percentage 
FROM
(
  SELECT YEAR(hire_date) as hire_year,count(*) as total_hire, 
  sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminations
  FROM hr
  WHERE age >= 18
  GROUP BY YEAR(hire_date)
) subquery 
ORDER BY hire_year;

-- 11. What is the average tenure distribution for each department?
select department, 
round(AVG(DATEDIFF(termdate, hire_date)/365.25),2) AS avg_tenure 
from hr 
where termdate is not null and termdate <= curdate() and age >= 18
group by department
order by avg_tenure desc;
