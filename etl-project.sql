SELECT * FROM county_population;

SELECT *  FROM zipcode_county;
--fact table

SELECT * FROM zipcode_cases;

SELECT * FROM zipcode_vaccination;

SELECT zc.zip_code, county, confirmed_cases, total_vaccinated
FROM zipcode_cases zc
INNER JOIN zipcode_vaccination zv
ON zc.zip_code = zv.zip_code
INNER JOIN zipcode_county zco
ON zc.zip_code = zco.zip_code;

SELECT zco.county, ROUND(AVG(pop_2019),0) AS population, SUM(confirmed_cases) AS total_cases, SUM(total_vaccinated) AS total_vaccinated
FROM zipcode_cases zc
INNER JOIN zipcode_vaccination zv
ON zc.zip_code = zv.zip_code
INNER JOIN zipcode_county zco
ON zc.zip_code = zco.zip_code
INNER JOIN county_population cp
ON cp.county = zco.county
GROUP BY zco.county;

SELECT zco.county, ROUND(AVG(pop_2019),0) AS population, SUM(confirmed_cases) AS total_cases, SUM(total_vaccinated) AS total_vaccinated,
ROUND((100 * SUM(confirmed_cases)/ROUND(AVG(pop_2019),0)),2) AS cases_percent,
ROUND((100 * SUM(total_vaccinated)/ROUND(AVG(pop_2019),0)),2) AS vaccinated_percent
FROM zipcode_cases zc
INNER JOIN zipcode_vaccination zv
ON zc.zip_code = zv.zip_code
INNER JOIN zipcode_county zco
ON zc.zip_code = zco.zip_code
INNER JOIN county_population cp
ON cp.county = zco.county
GROUP BY zco.county;