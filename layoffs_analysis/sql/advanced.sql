use lay_offs;
select * from staging_two;

with location_based_layoffs as (
select location, avg(total_laid_off) as average_lay_offs
from staging_two
group by location
order by average_lay_offs desc
) , rankings as (
SELECT location, average_lay_offs,dense_rank() over(order by average_lay_offs desc) as ranks
 from location_based_layoffs )

select * from rankings where ranks <= 5;

with country_based_layoffs as (
select 
country, avg(total_laid_off) as average_total_lays,dense_rank() over( order by avg(total_laid_off) desc) as ranks
 from staging_two group by country order by average_total_lays desc)
select * from country_based_layoffs where ranks <= 10;

with industry_based_layoffs as (
select industry , avg(total_laid_off) as average_lays, dense_rank() over(order by avg(total_laid_off) desc) as rankings
from staging_two
group by industry
having industry is not null or industry = ''
order by average_lays desc)

select * from industry_based_layoffs where rankings >= 10;


select * from staging_two;

select distinct year(`date`) from staging_two;
select year(`date`) as year, sum(total_laid_off) as total_lays
from staging_two
group by year order by year;

--rolling total based on the year
with yearly_table as (
select year(`date`) as year, sum(total_laid_off) as total_lays
from staging_two
group by year order by year
) select *, sum(total_lays) over(order by year) as rolling_year_totals from yearly_table;

--rolling yearly-months total
with monthly_totals as (
select substring(`date`,1,7) as month_year, sum(total_laid_off) as total_lays
from staging_two
group by month_year
order by month_year asc)
select * , sum(total_lays) over(order by month_year)
from monthly_totals;

--rolling total based on years 
with total_yearly_lays as (
select country,year(`date`) as years, sum(total_laid_off) as total_lays
from staging_two
group by country,years
order by country,years)

select *, sum(total_lays) over(partition by country order by years asc)as totals 
from total_yearly_lays;

with industry_annually_layoffs as (
select industry,year(`date`) as years, sum(total_laid_off) as total_lays 
from staging_two
group by industry,years
order by industry,years)

select *, sum(total_lays) over(PARTITION BY industry order by years) as yearly_rates
from industry_annually_layoffs;

--yearly funds raised per industry
with annuall_raisings as (
select industry, year(`date`) as years, sum(funds_raised_millions) as funds_raised
from staging_two
group by industry, years
order by industry, years)

select *, sum(funds_raised) over(partition by industry order by years) as yearly_raise
from annuall_raisings;

with country_annuall_raising as (
select country, year(`date`) as years, sum(funds_raised_millions) as funds_raised
from staging_two
group by country, years
order by country, years)

select * , sum(funds_raised)  over(PARTITION BY country order by years) as annual_totals 
from country_annuall_raising;

