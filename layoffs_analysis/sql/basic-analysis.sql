use lay_offs;
show tables;

select * from staging_two limit 20;

select distinct count('company') from staging_two;
--there are 1995 distinct companies in the dataset

select distinct sum(total_laid_off),avg(total_laid_off),max(total_laid_off), min(total_laid_off) from staging_two;
--total laid off employees  across the whole compnies in the dataset is 383,659,average = 237.2659, max(12000) min=3

select company,industry,country , total_laid_off from staging_two where total_laid_off = 3;

select DISTINCT `location`, sum(total_laid_off),avg(total_laid_off),max(total_laid_off),min(total_laid_off) from staging_two group by location order by avg(total_laid_off) desc;
--selected sum of total_laid off based on the location

select distinct industry, sum(total_laid_off),avg(total_laid_off),max(total_laid_off),min(total_laid_off) from staging_two group by industry  order by avg(total_laid_off) desc;
--foound the total numbers of employees laid off based on the industry they worked on


select * from staging_two;

SELECT YEAR(`date`) as year,sum(total_laid_off) as total_lays
from staging_two
group by year
order by total_lays desc;

select distinct country, count(company)
from staging_two
group by country
order by count(company) desc;

select * from staging_two where country = 'Kenya';

select stage, count(company) as companies
from staging_two
group by stage
order by companies desc;

select * from staging_two where stage = 'Subsidiary';

select country,
max(funds_raised_millions) as max_funds, min(funds_raised_millions) as min_funds,avg(funds_raised_millions) as avg_funds,
sum(funds_raised_millions) total_funds
from staging_two
group by country
order by total_funds desc;

select * from staging_two where company = 'Google' or company = 'Amazon';