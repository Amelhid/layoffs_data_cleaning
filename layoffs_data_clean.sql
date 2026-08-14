select * 
from layoffs;

create table layoffs2
like layoffs;

select * 
from layoffs2;

insert into layoffs2
select * from layoffs;
 

select * , 
row_number() over (
PARTITION BY company, industry , total_laid_off, percentage_laid_off, `date` ) as row_num
from layoffs2;

WITH dup AS ( 
	select * , 
	row_number() over (
	PARTITION BY company , location ,industry , total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) as row_num
	from layoffs2) 
select * 
from dup 
where row_num>1;



CREATE TABLE `layoffs3` (
  `company` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `industry` text DEFAULT NULL,
  `total_laid_off` int(11) DEFAULT NULL,
  `percentage_laid_off` text DEFAULT NULL,
  `date` text DEFAULT NULL,
  `stage` text DEFAULT NULL,
  `country` text DEFAULT NULL,
  `funds_raised_millions` int(11) DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
 select * 
from layoffs3
where row_num>1;

INSERT INTO layoffs3
select * , 
	row_number() over (
	PARTITION BY company , location ,industry , total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) as row_num
	from layoffs2;
    
DELETE 
from layoffs3
where row_num>1;

-- standardize 

SELECT * 
FROM layoffs3;

UPDATE layoffs3
set company= trim(company);


SELECT Distinct industry 
FROM layoffs3
order by 1;

SELECT * 
FROM layoffs3
where industry like 'Crypto%';

update layoffs3
SET industry= 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT Distinct country 
FROM layoffs3
order by 1;

UPDATE layoffs3 
SET country = trim(trailing '.' from country)
WHERE country  LIKE 'United states%';
 
 

select `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
from layoffs3;

UPDATE layoffs3
SET `date`= STR_TO_DATE(`date`,'%m/%d/%Y');

select * 
FROM layoffs3;

ALTER TABLE layoffs3
MODIFY COLUMN `date` DATE;


select *
from layoffs3
where total_laid_off is NULL
and  percentage_laid_off is null;

select *
from layoffs3
where industry is NULL
OR industry ='';

select *
from layoffs3 
where company ='Airbnb';


select l1.industry , l2.industry 
from layoffs3 l1
join layoffs3 l2
	on l1.company=l2.company
    and l1.location =l2.location
where (l1.industry is null or l1.industry ='')
and l2.industry is not null;

update layoffs3
set industry = null
where industry ='';

UPDATE layoffs3 l1
JOIN layoffs3 l2 
	ON l1.company=l2.company 
SET l1.industry=l2.industry
where l1.industry is null 
and l2.industry is not null;

DELETE 
FROM layoffs3
where total_laid_off is NULL
AND percentage_laid_off IS NULL; 

select * 
from layoffs3;


ALTER TABLE layoffs3
DROP COLUMN row_num;
