create database HRproject;

use HRproject;

-- Exploratory Analysis 
select * from hr;
select distinct gender from hr;
select distinct department from hr;
select distinct jobtitle from hr;
select distinct location from hr;
select distinct race from hr;

select max(birthdate), min(birthdate)
from hr;
select max(hire_date), min(hire_date)
from hr;
select max(termdate), min(termdate)
from hr;


   -- Check datatypes 
describe hr;

-- Data Cleaning

  -- 1. Change ï»¿id column to id
alter table hr
change column ï»¿id emp_id varchar(20) null;

  -- 2. Convert birthdate from string to date
  
  -- Enable updating feature in the database
  Set sql_safe_updates = 0;
  
update hr
set birthdate = case 
when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y%'),'%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y%'),'%Y-%m-%d')
else null end;

-- change bithdate datatype from string to date 
alter table hr
modify column birthdate date;

 -- 3. Convert hire_date from string to date
 
update hr
set hire_date = case 
when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y%'),'%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y%'),'%Y-%m-%d')
else null end; 

-- change hire_date datatype from string to date 
   alter table hr
   modify column hire_date date;

-- Convert hire_date from string to date

   UPDATE hr
   SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
   WHERE termdate IS NOT NULL AND termdate != ' ';

-- UPDATE hr SET termdate = IF(termdate = '', NULL, str_to_date(termdate, "%Y-%m-%d %H:%i:%s UTC")) WHERE termdate IS NOT NULL;

    select termdate from hr;

-- change termdate datatype from string to date 
   alter table hr
   modify column termdate date;



 -- Add Age column in the table
 
 alter table hr
 add column age int;
 
-- update Age column
update hr
set age = timestampdiff(YEAR,birthdate, CURDATE());

-- check the age colunm for any outliers

select min(age)youngest, max(age)oldest
from hr;

select count(age) from hr where age < 18 ;
