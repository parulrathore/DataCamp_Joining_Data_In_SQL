--Left Join
-- Select the city name (with alias), the country code,
-- the country name (with alias), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
  INNER JOIN countries AS c2
    -- Match on country code
    ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code desc;


SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
  -- Join right table (with alias)
  left JOIN countries AS c2
    -- Match on country code
    ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--Left join (2)

/*
Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
Select c.name AS country, local_name, l.name AS language, percent
-- From left table (alias as c)
FROM countries AS c
  -- Join to right table (alias as l)
  inner JOIN languages AS l
    -- Match on fields
    ON c.code = l.code
-- Order by descending country
ORDER BY country desc;


/*
Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
Select c.name AS country, local_name, l.name AS language, percent
-- From left table (alias as c)
FROM countries AS c
  -- Join to right table (alias as l)
  left JOIN languages AS l
    -- Match on fields
    ON c.code = l.code
-- Order by descending country
ORDER BY country DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--Left join (3)

-- Select name, region, and gdp_percapita
SELECT name,region, gdp_percapita
-- From countries (alias as c)
FROM countries AS c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE year= 2010;


-- Select fields
SELECT region, avg(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
FROM countries AS c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY region;


-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
from countries as c
  -- Left join with economies (alias as e)
  left join economies as e
    -- Match on code fields
   on c.code=e.code
-- Focus on 2010
where year=2010
-- Group by region
Group by region
-- Order by descending avg_gdp
Order by avg_gdp desc;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--Right join

-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM cities
  LEFT JOIN countries
    ON cities.country_code = countries.code
  LEFT JOIN languages
    ON countries.code = languages.code
ORDER BY city, language;
*/

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON languages.code = countries.code
  RIGHT JOIN cities
    ON cities.country_code = countries.code
ORDER BY city, language;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--Full join
SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
  -- Join to currencies
  FULL JOIN currencies
    -- Match on code
    USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS null
-- Order by region
ORDER BY region;


SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
  -- Join to currencies
  left join currencies
    -- Match on code
    using (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;


SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
  -- Join to currencies
  inner join currencies
    -- Match on code
    USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--Full join (2)
SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
  -- Join to countries
  full JOIN countries
    -- Match on code
    USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name asc;


SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
  -- Join to countries
  left join countries
    -- Match on code
    USING (code)
-- Where countries.name starts with V or is null
Where countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name;


SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
  -- Join to countries
  inner join countries
    -- Match using code
    USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
order by countries.name;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--Full join (3)
-- Select fields (with aliases)
SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
-- From countries (alias as c1)
FROM countries AS c1
  -- Join with languages (alias as l)
  FULL JOIN languages AS l
    -- Match on code
    USING (code)
  -- Join with currencies (alias as c2)
  FULL JOIN currencies AS c2
    -- Match on code
    USING (code)
-- Where region like Melanesia and Micronesia
WHERE region LIKE 'M%esia';

-----------------------------------------------------------------------------------------------------------------------------------------------------
--A table of two cities
-- Select fields
SELECT c.name AS city, l.name AS language
-- From cities (alias as c)
FROM cities AS c        
  -- Join to languages (alias as l)
  CROSS JOIN languages AS l
-- Where c.name like Hyderabad
WHERE c.name LIKE 'Hyder%';


-- Select fields
select c.name AS city, l.name AS language
-- From cities (alias as c)
from cities as c  
  -- Join to languages (alias as l)
  inner JOIN languages AS l
    -- Match on country code
    on c.country_code=l.code
-- Where c.name like Hyderabad
Where c.name like 'Hyder%';

-----------------------------------------------------------------------------------------------------------------------------------------------------
--Outer challenge
-- Select fields
Select c.name as country, c.region, p.life_expectancy as life_exp
-- From countries (alias as c)
from countries as c
  -- Join to populations (alias as p)
  left join populations as p
    -- Match on country code
    on c.code=p.country_code
-- Focus on 2010
where p.year= '2010'
-- Order by life_exp
Order by life_exp
-- Limit to 5 records
limit 5

























