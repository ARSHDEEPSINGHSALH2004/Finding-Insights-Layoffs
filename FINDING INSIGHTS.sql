-- BEGINNER LEVEL --

-- 1. What are the top 5 industries with the highest layoffs?
SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC
LIMIT 5;

-- 2. Which countries have experienced the most layoffs?
SELECT country, SUM(total_laid_off) AS total_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;

-- 3. What are the top 5 companies with the highest percentage of layoffs?
SELECT company, percentage_laid_off
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1;


-- 4. How many layoffs have occurred in each funding stage?
SELECT stage, SUM(total_laid_off) AS total_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY total_layoffs DESC;

-- INTERMEDIATE LEVEL --

-- 5. How have layoffs changed over time?
SELECT `date`, SUM(total_laid_off) AS total_layoffs
FROM world_layoffs.layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY `date`
ORDER BY `date`;



-- 6. Which companies raised the most funds before layoffs?
SELECT company, MAX(funds_raised_millions) AS max_funds, SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY max_funds DESC
LIMIT 5;


-- 7. What percentage of layoffs occurred in the Fin-tech industry compared to all industries?
SELECT 
    (SUM(CASE WHEN industry = 'Fin-Tech' THEN total_laid_off ELSE 0 END)) * 100.0 / SUM(total_laid_off) AS tech_layoff_percentage
FROM world_layoffs.layoffs_staging2;

-- 8. What are the top locations where layoffs happened the most?
SELECT location, SUM(total_laid_off) AS total_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY total_layoffs DESC
LIMIT 5;

-- ADVANCED LEVEL --

-- 9. What is the average percentage of layoffs for each industry?
SELECT industry, AVG(percentage_laid_off) AS avg_percentage_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY avg_percentage_laid_off DESC;

-- 10. Which companies had layoffs despite raising significant funding?
SELECT 
    company, 
    MAX(funds_raised_millions) AS max_funds_raised, 
    SUM(total_laid_off) AS total_laid_off_count
FROM world_layoffs.layoffs_staging2
WHERE funds_raised_millions > 1000   
AND total_laid_off > 0             
GROUP BY company
ORDER BY max_funds_raised DESC;



-- 11. Which industries have the highest layoffs relative to total funding raised?
SELECT industry, SUM(total_laid_off) / SUM(funds_raised_millions) AS layoffs_per_million
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY layoffs_per_million DESC;

-- 12. What is the trend of layoffs in startups vs. established companies?
SELECT 
    CASE 
        WHEN stage IN ('Seed', 'Series A', 'Series B') THEN 'Startup'
        ELSE 'Established'
    END AS company_type,
    SUM(total_laid_off) AS total_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY company_type
ORDER BY total_layoffs DESC;
