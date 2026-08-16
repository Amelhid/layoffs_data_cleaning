SELECT *
FROM layoffs3;
-- the biggest single layoff
SELECT company, max(total_laid_off)
FROM layoffs3;
 
 
 -- how big the layoffs were
SELECT 
    MAX(percentage_laid_off) AS max_percentage,
    MIN(percentage_laid_off) AS min_percentage
FROM layoffs3
WHERE percentage_laid_off IS NOT NULL;
-- companies that had 100% layoffs
SELECT company,percentage_laid_off
FROM layoffs3 
WHERE percentage_laid_off=1;

-- how big these companies were et the time 
SELECT company,percentage_laid_off, funds_raised_millions
FROM layoffs3 
WHERE percentage_laid_off=1
order by funds_raised_millions DESC;

-- companies with the biggest layoffs
SELECT company, total_laid_off
FROM layoffs3
ORDER BY 2 DESC
LIMIT 5;


-- companies with the most layoffs overall
SELECT company, SUM(total_laid_off) As total_laid_off
FROM layoffs3 
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY 2 DESC ;


SELECT location, SUM(total_laid_off) AS total_laid_off
FROM layoffs3 
WHERE total_laid_off IS NOT NULL
GROUP BY location
ORDER BY 2 DESC 
LIMIT 10;

SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs3 
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY 2 DESC ;

SELECT year(date) , SUM(total_laid_off) AS total_laid_off
FROM layoffs3 
WHERE total_laid_off IS NOT NULL
GROUP BY year(date)
ORDER BY 2 DESC ;

SELECT  substring(`date`, 6,2 ) AS month , SUM(total_laid_off) as total_laid_off
FROM layoffs3
Group BY month
ORDER BY SUM(total_laid_off) DESC;


SELECT industry , SUM(total_laid_off) AS total_laid_off
FROM layoffs3 
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY 2 DESC ;

SELECT stage , SUM(total_laid_off) AS total_laid_off
FROM layoffs3 
WHERE total_laid_off IS NOT NULL
GROUP BY stage
ORDER BY 2 DESC ;

-- company with the most layoffs per year

WITH company_year (company , years, total_laid_off) AS
( 
select company, year(date) , sum(total_laid_off)
from layoffs3
group by company, year(date)
), Company_year_rank AS
(select *, dense_rank() over ( partition by years order by total_laid_off DESC) as ranking 
FROM company_year
where years IS NOT NULL
) select * 
from company_year_rank
where ranking <=5;

-- total layoffs per month

SELECT substring( date,1,7)  as dates, SUM(total_laid_off) As total_laid_off
from layoffs3
group by dates
order by dates asc;
-- rolling total of layoffs over time
with rolling_total as 
( SELECT substring( date,1,7)  as dates, SUM(total_laid_off) As total_laid_off
from layoffs3
group by dates
order by dates asc)
select dates, total_laid_off, sum(total_laid_off) over ( order by dates asc ) as layoffs_per_month
from rolling_total
order by dates;


