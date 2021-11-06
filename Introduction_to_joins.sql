--Inner join
-- Select all columns from cities
select *
from cities

SELECT * 
FROM cities
  -- Inner join to countries
  INNER JOIN countries
    -- Match on the country codes
    ON cities.country_code = countries.code;
	
-- Select name fields (with alias) and region 
SELECT cities.name as City, countries.name as country, countries.region
FROM cities
  INNER JOIN countries
    ON cities.country_code = countries.code;
----------------------------------------------------------------------------------------------------------------------------------------------------
--Inner join (2)

-- Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
  -- Join to economies (alias e)
  INNER JOIN economies as e
    -- Match on code
    ON c.code = e.code;	
----------------------------------------------------------------------------------------------------------------------------------------------------
--Inner join (3)

-- Select fields
select c.code,c.name,c.region,p.year, p.fertility_rate
  -- From countries (alias as c)
from countries as c
  -- Join with populations (as p)
  inner join populations as p
    -- Match on country code
    on c.code=p.country_code	
	
-- Select fields
SELECT c.code, name, region,e.year, fertility_rate, e.unemployment_rate
  -- From countries (alias as c)
  FROM countries AS c
  -- Join to populations (as p)
  INNER JOIN populations AS p
    -- Match on country code
    ON c.code = p.country_code
  -- Join to economies (as e)
  INNER join economies as e
    -- Match on country code
    ON p.country_code=e.code;

-- Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- From countries (alias as c)
  FROM countries AS c
  -- Join to populations (as p)
  INNER JOIN populations AS p
    -- Match on country code
    ON c.code = p.country_code
  -- Join to economies (as e)
  INNER JOIN economies AS e
    -- Match on country code and year
    ON p.country_code= e.code and
    p.year=e.year;	
----------------------------------------------------------------------------------------------------------------------------------------------------
--Inner join with using

-- Select fields
-- From countries (alias as c)
-- Join to languages (as l)
-- Match using code    
select countries.name as country, continent, languages.name as language, official
from countries 
inner join languages
using (code)  	
----------------------------------------------------------------------------------------------------------------------------------------------------
--Self-join

-- Select fields with aliases
-- From populations (alias as p1)
-- Join to itself (alias as p2)
-- Match on country code
 

 Select p1.country_code, p1.size as size2010, p2.size as size2015
 from populations as p1, populations as p2
 where p1.country_code=p2.country_code
 
 
 -- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015
-- From populations (alias as p1)
FROM populations as p1
  -- Join to itself (alias as p2)
  inner JOIN populations as p2
    -- Match on country code
    ON p1.country_code = p2.country_code
        -- and year (with calculation)
        and p1.year=p2.year-5
		

-- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       -- Calculate growth_perc
        ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
-- From populations (alias as p1)
FROM populations AS p1
  -- Join to itself (alias as p2)
  INNER JOIN populations AS p2
    -- Match on country code
    ON p1.country_code = p2.country_code
        -- and year (with calculation)
        AND p1.year = p2.year - 5;	
		
--------------------------------------------------------------------------------------------------------------------------------------------------------Case when and then
SELECT name, continent, code, surface_area,
    -- First case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- Second case
        WHEN surface_area> 350000 THEN 'medium'
        -- Else clause + end
        ELSE 'small' END
        -- Alias name
        AS geosize_group
-- From table
FROM countries;

------------------------------------------------------------------------------------------------------------------------------------------------------
--Inner challenge
SELECT country_code, size,
    -- First case
    CASE WHEN size > 50000000 THEN 'large'
        -- Second case
        WHEN size > 1000000 THEN 'medium'
        -- Else clause + end
        ELSE 'small' END
        -- Alias name (popsize_group)
        AS popsize_group
-- From table
FROM populations
-- Focus on 2015
WHERE year = 2015;


SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
-- Into table
Into pop_plus
FROM populations
WHERE year = 2015;

-- Select all columns of pop_plus
Select * from pop_plus


SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;

-- Select fields
-- From countries_plus (alias as c)
-- Join to pop_plus (alias as p)
-- Match on country code
-- Order the table    

Select c.name, c.continent, c.geosize_group, p.popsize_group
from countries_plus as c 
inner Join pop_plus as p
on c.code=p.country_code
order by geosize_group asc
		
