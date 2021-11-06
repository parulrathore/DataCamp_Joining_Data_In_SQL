--Union
-- Select fields from 2010 table
select *
  -- From 2010 table
  from economies2010
	-- Set theory clause
	union
-- Select fields from 2015 table
select *
  -- From 2015 table
  from economies2015
-- Order by code and year
order by code, year;

---------------------------------------------------------------------------------------------------------------------------------------------
--Union (2)

-- Select field
select country_code
  -- From cities
  from cities
	-- Set theory clause
	union
-- Select field
select code as country_code
  -- From currencies
  from currencies
-- Order by country_code
order by country_code;

---------------------------------------------------------------------------------------------------------------------------------------------
--Union all
-- Select fields
SELECT code, year
  -- From economies
  FROM economies
	-- Set theory clause
	union all
-- Select fields
SELECT country_code as code, year
  -- From populations
  FROM populations
-- Order by code, year
ORDER BY code, year;

---------------------------------------------------------------------------------------------------------------------------------------------
--Intersect
-- Select fields
Select code, year
  -- From economies
  from economies
	-- Set theory clause
	intersect
-- Select fields
Select country_code as code, year
  -- From populations
  from populations
-- Order by code and year
order by code, year;

---------------------------------------------------------------------------------------------------------------------------------------------
--Intersect (2)

-- Select fields
select name
  -- From countries
  from countries
	-- Set theory clause
  intersect
-- Select fields
	select name
  -- From cities
  from cities;
  
----------------------------------------------------------------------------------------------------------------------------------------------
--Except

-- Select field
SELECT name
  -- From cities
  FROM cities
	-- Set theory clause
	except
-- Select field
SELECT capital
  -- From countries
  FROM countries
-- Order by result
ORDER BY name asc;

----------------------------------------------------------------------------------------------------------------------------------------------
--Except (2)

-- Select field
select capital
  -- From countries
  from countries
	-- Set theory clause
	except
-- Select field
Select name
  -- From cities
  from cities
-- Order by ascending capital
order by capital asc;

----------------------------------------------------------------------------------------------------------------------------------------------
--Semi-join
-- Select code
Select code
  -- From countries
  from countries
-- Where region is Middle East
where region= 'Middle East';


----------------------------------------------------------------------------------------------------------------------------------------------
--Diagnosing problems using anti-join
-- Select statement
-- From countries
-- Where continent is Oceania

select count(*)
from countries
where continent = 'Oceania'

----------------------------------------------------------------------------------------------------------------------------------------------
--Diagnosing problems using anti-join

-- Select statement
-- From countries
-- Where continent is Oceania

select count(*)
from countries
where continent = 'Oceania'

-- Select fields (with aliases)
-- From countries (alias as c1)
-- Join with currencies (alias as c2)
-- Match on code
-- Where continent is Oceania

select c1.code as code, c1.name as name, basic_unit as currency
from countries as c1 
inner join currencies as c2
on c1.code=c2.code
where continent ='Oceania'

-- Select fields
-- From Countries
-- Where continent is Oceania
-- And code not in
-- Subquery
  	
select code, name
from Countries
where continent='Oceania'
and code not in 
(
	select code 
	from currencies
)	  

----------------------------------------------------------------------------------------------------------------------------------------------
--Set theory challenge

-- Select the city name
Select name
  -- Alias the table where city name resides
  from cities AS c1
  -- Choose only records matching the result of multiple set theory clauses
  WHERE c1.country_code IN
(
    -- Select appropriate field from economies AS e
    SELECT e.code
    FROM economies AS e
    -- Get all additional (unique) values of the field from currencies AS c2  
    union

    SELECT c2.code
    FROM currencies AS c2
    -- Exclude those appearing in populations AS p
    except
    SELECT p.country_code
    FROM populations AS p
);




