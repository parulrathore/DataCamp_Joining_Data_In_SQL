--Subquery inside where
-- Select average life_expectancy
-- From populations
-- Where year is 2015
Select avg(life_expectancy)
from populations
where year =2015

-- Select fields-- From populations
-- Where life_expectancy is greater than
-- 1.15 * subquery

Select * 
from populations
where year=2015 and 
life_expectancy> 1.15 * (
  select avg(life_expectancy)
  from populations
  where year=2015)
  --and year=2015

---------------------------------------------------------------------------------------------------------------------------------------------
--Subquery inside where (2)

/*-- Select fields
___ ___, ___, urbanarea_pop
  -- From cities
  ___ ___
-- Where city name in the field of capital cities
___ ___ IN
  -- Subquery
  (___ ___
   ___ ___)
ORDER BY urbanarea_pop DESC;*/


select name, country_code, urbanarea_pop
from cities
where name in (
  select capital
  from countries
)
ORDER by urbanarea_pop desc

---------------------------------------------------------------------------------------------------------------------------------------------
--Subquery inside select
SELECT countries.name AS country, COUNT(*) AS cities_num
  FROM cities
    INNER JOIN countries
    ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9;

/* 
SELECT ___ AS ___,
  (SELECT ___
   FROM ___
   WHERE countries.code = cities.country_code) AS cities_num
FROM ___
ORDER BY ___ ___, ___
LIMIT 9;
*/

---------------------------------------------------------------------------------------------------------------------------------------------
--Subquery inside from
/*-- Select fields (with aliases)
___
  -- From languages
  ___
-- Group by code
___;*/

Select code, count(*) as lang_num
from languages 
group by code

-- Select fields
Select local_name, subquery.lang_num
  -- From countries
  from countries,
  	-- Subquery (alias as subquery)
  	(SELECT code, COUNT(name) AS lang_num
  	 FROM languages
  	 GROUP BY code) AS subquery
  -- Where codes match
  where countries.code=subquery.code
-- Order by descending number of languages
Order by lang_num desc;

---------------------------------------------------------------------------------------------------------------------------------------------
--Advanced subquery
/*-- Select fields
___
  -- From countries
  ___
  	-- Join to economies
  	___
    -- Match on code
    ___
-- Where year is 2015
___;*/


select countries.name, countries.continent, economies.inflation_rate
from countries 
inner join economies
using(code)
where year=2015

-- Select the maximum inflation rate as max_inf
Select max(inflation_rate) as max_inf
  -- Subquery using FROM (alias as subquery)
  FROM (
      SELECT name, continent, inflation_rate
      FROM countries
      INNER JOIN economies
      USING (code)
      WHERE year = 2015) AS subquery
-- Group by continent
group by continent;

-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
  FROM countries
	-- Join to economies
	INNER JOIN economies
	-- Match on code
	on countries.code=economies.code
  -- Where year is 2015
  WHERE year = 2015
    -- And inflation rate in subquery (alias as subquery)
    and inflation_rate in (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             on countries.code=economies.code
             WHERE year = 2015) AS subquery
      -- Group by continent
        GROUP BY continent);
		
---------------------------------------------------------------------------------------------------------------------------------------------
--Subquery challenge
-- Select fields
SELECT code, inflation_rate, unemployment_rate
  -- From economies
  FROM economies
  -- Where year is 2015 and code is not in
  WHERE year=2015 AND code not in
  	-- Subquery
  	(SELECT code
  	 FROM countries
  	 WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic'))
-- Order by inflation rate
ORDER BY inflation_rate asc;		

---------------------------------------------------------------------------------------------------------------------------------------------
--Final challenge
-- Select fields
SELECT DISTINCT c.name, e.total_investment, e.imports
  -- From table (with alias)
  FROM economies AS e
    -- Join with table (with alias)
    LEFT JOIN countries AS c
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND c.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  -- Where region and year are correct
  WHERE c.region = 'Central America' AND e.year = 2015
-- Order by field
ORDER BY c.name asc;

---------------------------------------------------------------------------------------------------------------------------------------------
--Final challenge (2)
-- Select fields
SELECT c.region, c.continent, avg(fertility_rate) AS avg_fert_rate
  -- From left table
  FROM countries AS c
    -- Join to right table
    INNER JOIN populations AS p
      -- Match on join condition
      ON c.code = p.country_code
  -- Where specific records matching some condition
  WHERE year = 2015
-- Group appropriately
GROUP BY region, continent
-- Order appropriately
ORDER BY avg_fert_rate;

---------------------------------------------------------------------------------------------------------------------------------------------
--Final challenge (3)
-- Select fields
SELECT name, country_code, city_proper_pop, metroarea_pop,  
      -- Calculate city_perc
      city_proper_pop / metroarea_pop * 100 AS city_perc
  -- From appropriate table
  FROM cities
  -- Where 
  WHERE name IN
    -- Subquery
    (SELECT capital
     FROM countries
     WHERE (continent = 'Europe'
        OR continent LIKE '%America'))
       AND metroarea_pop IS not null
-- Order appropriately
ORDER BY city_perc desc
-- Limit amount
Limit 10;